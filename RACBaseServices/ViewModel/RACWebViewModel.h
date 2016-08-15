//
//  RACWebViewModel.h
//  MarkeJave
//
//  Created by MarkeJave on 15/1/24.
//  Copyright (c) 2015年 MarkeJave. All rights reserved.
//

#import "RACControllerViewModel.h"
#import <WebKit/WebKit.h>

extern NSString * const RACWebViewModelRequestKey;

@interface RACWebViewModel : RACControllerViewModel

@property (nonatomic, copy  ) NSURLRequest *request;

@property (nonatomic, strong) NSArray<NSString *> *shieldHosts;

@property (nonatomic, strong) NSArray<NSString *> *turnSchemes;

@property (nonatomic, strong) NSArray<NSString *> *turnHosts;

@property (nonatomic, strong) NSArray<WKUserScript *> *javaScriptAfterWebViewLoaded;

@property (nonatomic, copy  ) NSString *javaScriptPerformance;

@property (nonatomic, copy  ) NSString *userAgent;

@property (nonatomic, copy  ) NSString *appendUserAgentComponent;

@property (nonatomic, assign) BOOL textUserInterfaceEnable;  // If YES, user's actions will be enable, such as select, copy and so on, default is YES.

@property (nonatomic, assign) BOOL webpageJumpEnable;        // If YES, webpage link will be available, default is YES.

@property (nonatomic, assign) BOOL sharable;

@property (nonatomic, strong, readonly) RACCommand *didTurnSchemeCommand;

@property (nonatomic, strong, readonly) RACCommand *didTurnHostCommand;

@property (nonatomic, strong, readonly) RACCommand *didClickShareCommand;

- (RACSignal *)responseSignalToSchemeRequest:(NSURLRequest *)request;

- (RACSignal *)responseSignalToHostRequest:(NSURLRequest *)request;

- (RACSignal *)requestShareSignal;

@end
