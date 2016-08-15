//
//  RACWebViewController
//  MarkeJave
//
//  Created by MarkeJave on 15/1/24.
//  Copyright (c) 2015年 MarkeJave. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface RACWebViewController : UIViewController <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong, readonly) WKWebView *webView;

@end
