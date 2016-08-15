//
//  RACControllerViewModel
//  MarkeJave
//
//  Created by MarkeJave on 14/12/27.
//  Copyright (c) 2014年 MarkeJave. All rights reserved.
//

#import "RACControllerViewModel.h"
#import "RACViewController.h"

NSString * const RACControllerViewModelTitleKey = @"title";

@interface RACControllerViewModel ()

@property (nonatomic, strong) RACSubject *willAppearSignal;

@property (nonatomic, strong) RACSubject *didAppearSignal;

@property (nonatomic, strong) RACSubject *willDisappearSignal;

@property (nonatomic, strong) RACSubject *didDisappearSignal;

@property (nonatomic, strong) id<RACViewModelServices> services;

@property (nonatomic, copy  ) NSDictionary *params;

@end

@implementation RACControllerViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    RACControllerViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel)
    [[viewModel rac_signalForSelector:@selector(initWithServices:params:)] subscribeNext:^(id x) {
        @strongify(viewModel)
        [viewModel initialize];
    }];
    return viewModel;
}

- (instancetype)initWithServices:(id<RACViewModelServices>)services params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.shouldFetchLocalDataOnViewModelInitialize = YES;
        self.shouldRequestRemoteDataOnViewDidLoad = YES;
        self.title    = params[RACControllerViewModelTitleKey];
        self.services = services;
        self.params   = params;
    }
    return self;
}

- (RACSubject *)willAppearSignal {
    if (!_willAppearSignal) _willAppearSignal = [RACSubject subject];
    return _willAppearSignal;
}

- (RACSubject *)didAppearSignal {
    if (!_didAppearSignal) _didAppearSignal = [RACSubject subject];
    return _didAppearSignal;
}

- (RACSubject *)willDisappearSignal {
    if (!_willDisappearSignal) _willDisappearSignal = [RACSubject subject];
    return _willDisappearSignal;
}

- (RACSubject *)didDisappearSignal{
    if (!_didDisappearSignal) _didDisappearSignal = [RACSubject subject];
    return _didDisappearSignal;
}

- (Class<RACViewControllerProtocol>)viewControllerClass{
    return [UIViewController class];
}

- (void)initialize {}

- (void)popBackViewModel;{
    [[self services] popViewModelAnimated:YES];
}

- (void)dismissBackViewModel:(void (^)())completion;{
    [[self services] dismissViewModelAnimated:YES completion:completion];
}

- (void)popBackToRootViewModel;{
    [[self services] popToRootViewModelAnimated:YES];
}

@end
