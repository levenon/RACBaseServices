//
//  RACWebViewModel.m
//  MarkeJave
//
//  Created by MarkeJave on 15/1/24.
//  Copyright (c) 2015年 MarkeJave. All rights reserved.
//

#import "RACWebViewModel.h"

#import "RACViewController.h"

#import "RACWebViewController.h"

NSString * const RACWebViewModelRequestKey = @"request";

@interface RACWebViewModel ()

@property (nonatomic, strong) RACCommand *didTurnSchemeCommand;

@property (nonatomic, strong) RACCommand *didTurnHostCommand;

@property (nonatomic, strong) RACCommand *didClickShareCommand;

@end

@implementation RACWebViewModel

- (instancetype)initWithServices:(id<RACViewModelServices>)services params:(NSDictionary *)params;{
    self = [super initWithServices:services params:params];
    if (self) {
        self.request = params[RACWebViewModelRequestKey];
        self.turnSchemes = @[@"turn"];
        self.textUserInterfaceEnable = NO;
        self.webpageJumpEnable = NO;
    }
    return self;
}

- (void)initialize{
    [super initialize];
    
    @weakify(self);
    self.didTurnSchemeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSURLRequest *request) {
        @strongify(self);
        return  [self responseSignalToSchemeRequest:request];
    }];
    
    self.didTurnHostCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSURLRequest *request) {
        @strongify(self);
        return  [self responseSignalToHostRequest:request];
    }];
    
    self.didClickShareCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [[self requestShareSignal] takeUntil:[self rac_willDeallocSignal]];
    }];
}

- (RACSignal *)responseSignalToSchemeRequest:(NSURLRequest *)request{
    return [RACSignal empty];
}

- (RACSignal *)responseSignalToHostRequest:(NSURLRequest *)request;{
    return [RACSignal empty];
}

- (RACSignal *)requestShareSignal;{
    return [RACSignal empty];
}

#pragma mark - accessor

- (Class)viewControllerClass{
    return [RACWebViewController class];
}

@end
