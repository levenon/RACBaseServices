//
//  RACWebViewController
//  MarkeJave
//
//  Created by MarkeJave on 15/1/24.
//  Copyright (c) 2015年 MarkeJave. All rights reserved.
//

#import "RACWebViewController.h"
#import "RACWebViewModel.h"
#import "RACLog.h"

@interface RACWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIBarButtonItem *shareBarButtonItem;

@property (nonatomic, strong, readonly) RACWebViewModel *viewModel;

@end

@implementation RACWebViewController
@dynamic viewModel;

- (void)loadView{
    [super loadView];
    [[self view] addSubview:[self webView]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[self webView] scrollView] setContentInset:UIEdgeInsetsMake(20 + 44, 0, 0, 0)];
    
    @weakify(self);
    RACTitleViewType type = [[self viewModel] titleViewType];
    RAC([self viewModel], titleViewType) = [RACObserve([self webView], loading) map:^id(NSNumber *loading) {
        return @([loading boolValue] ? RACTitleViewTypeLoadingTitle : type);
    }];
    
    [RACObserve([self viewModel], sharable) subscribeNext:^(NSNumber *sharable) {
        @strongify(self);
        if ([sharable boolValue]) {
            self.navigationItem.rightBarButtonItem = [self shareBarButtonItem];
        } else {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }];
    
    [self shareBarButtonItem].rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [[[self viewModel] didClickShareCommand] execute:nil];
        return [RACSignal empty];
    }];
    
    [[[RACObserve([self viewModel], appendUserAgentComponent) distinctUntilChanged] ignore:nil] subscribeNext:^(NSString *appendUserAgentComponent) {
        @strongify(self);
        UIWebView *webView = [[UIWebView alloc] initWithFrame:[[self view] bounds]];
        NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        NSString *newUserAgent = [userAgent stringByAppendingString:appendUserAgentComponent];
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":newUserAgent}];
    }];
    
    [[[RACObserve([self viewModel], userAgent) distinctUntilChanged] ignore:nil] subscribeNext:^(NSString *userAgent) {
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":userAgent}];
    }];
    
    NSParameterAssert([[self viewModel] request]);
    [[RACObserve([self viewModel], request) ignore:nil] subscribeNext:^(NSURLRequest *request) {
        @strongify(self);
        [[self webView] loadRequest:request];
    }];
    
    [[RACObserve([self viewModel], javaScriptPerformance) ignore:nil] subscribeNext:^(NSString *javaScriptPerformance) {
        @strongify(self);
        [[self webView] evaluateJavaScript:javaScriptPerformance completionHandler:^(id result, NSError *error) {
            if (error) {
                RAC_ERROR(@"ERROR: webview evaluate JavaScript failed.");
            } else {
                RAC_DEBUG(@"INFO: webview evaluating JavaScript with received result: %@", result);
            }
        }];
    }];
    
    [[[[self webView] rac_signalForSelector:@selector(evaluateJavaScript:completionHandler:)] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(RACTuple *tuple) {
        RAC_DEBUG(@"webview evaluate JavaScript : %@", [tuple first]);
    }];
    
    [[self webView] evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        RAC_DEBUG(@"User Agent: %@", result);
    }];
}

#pragma mark - getter and setter

- (WKWebView*)webView{
    if (!_webView) {
        WKPreferences *preferences = [[WKPreferences alloc] init];
        preferences.javaScriptEnabled = YES;
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        for (WKUserScript *javaScript in [[self viewModel] javaScriptAfterWebViewLoaded]) {
            [userContentController addUserScript:javaScript];
        }
        
        WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        if ([webViewConfiguration respondsToSelector:@selector(setWebsiteDataStore:)]) {
            webViewConfiguration.websiteDataStore = [WKWebsiteDataStore defaultDataStore];
        }
        webViewConfiguration.preferences = preferences;
        webViewConfiguration.userContentController = userContentController;
        webViewConfiguration.allowsInlineMediaPlayback = YES;
        
        _webView = [[WKWebView alloc] initWithFrame:[[self view] bounds] configuration:webViewConfiguration];
        [_webView setUIDelegate:self];
        [_webView setNavigationDelegate:self];
        [_webView setBackgroundColor:[UIColor whiteColor]];
        [[_webView scrollView] setShowsHorizontalScrollIndicator:NO];
        [[_webView scrollView] setShowsVerticalScrollIndicator:NO];
    }
    return _webView;
}

- (UIBarButtonItem *)shareBarButtonItem{
    if (!_shareBarButtonItem) {
        _shareBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_share_transparent_normal"]
                                                               style:UIBarButtonItemStyleDone
                                                              target:nil
                                                              action:nil];
    }
    return _shareBarButtonItem;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;{
    if (![[self viewModel] textUserInterfaceEnable]) {
        [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
        [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    }
    if (![[self title] length]) {
        [self setTitle:[webView title]];
    }
    if (![[self title] length]) {
        [self setTitle:@"网页"];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;{
    RAC_ERROR(@"ERROR: webView did load failed.");
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;{
    NSURLRequest *request = [navigationAction request];
    NSURL *url = [request URL];
    if (![[self viewModel] webpageJumpEnable]) {
        if (([[url scheme] isEqualToString: @"http"] ||
             [[url scheme] isEqualToString:@"https"] ||
             [[url scheme] isEqualToString: @"mailto" ] ||
             [[[self viewModel] shieldHosts] containsObject:[url host]]) &&
            ([navigationAction navigationType] == UIWebViewNavigationTypeLinkClicked)) {
            decisionHandler(WKNavigationActionPolicyCancel);
        } else if ([[[self viewModel] turnSchemes] containsObject:[url scheme]]) {
            if ([[[self viewModel] turnHosts] containsObject:[url host]]) {
                [[[self viewModel] didTurnHostCommand] execute:request];
            } else {
                [[[self viewModel] didTurnSchemeCommand] execute:request];
            }
            decisionHandler(WKNavigationActionPolicyCancel);
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
