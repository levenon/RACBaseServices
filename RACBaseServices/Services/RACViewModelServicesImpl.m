//
//  RACControllerViewModelServicesImpl.m
//  UDrivingCustomer
//
//  Created by MarkeJave on 14/12/27.
//  Copyright (c) 2014年 MarkeJave. All rights reserved.
//

#import "RACViewModelServicesImpl.h"

@implementation RACViewModelServicesImpl

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)pushViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated {}
- (void)pushViewModelToBeRootViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated {}
- (void)pushViewModel:(RACControllerViewModel *)viewModel followByViewModel:(RACControllerViewModel *)followedViewModel animated:(BOOL)animated {}
- (void)pushViewModel:(RACControllerViewModel *)viewModel replaceViewModel:(RACControllerViewModel *)replacedViewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}
- (void)popViewModelAnimated:(BOOL)animated completeBlock:(void(^)(id<RACNavigationProtocol> navgation))completeBlock {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}
- (void)popToRootViewModelAnimated:(BOOL)animated completeBlock:(void(^)(id<RACNavigationProtocol> navgation))completeBlock {}

- (void)popToViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated completeBlock:(void(^)(id<RACNavigationProtocol> navgation))completeBlock {};

- (void)presentViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated completion:(void (^)())completion {}
- (void)presentNavigationWithRootViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated completion:(void (^)())completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^)())completion {}

- (void)resetRootViewModel:(RACControllerViewModel *)viewModel {}
- (void)resetRootNavigationWithViewModel:(RACControllerViewModel *)viewModel {}

@end
