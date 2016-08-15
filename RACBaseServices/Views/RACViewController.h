//
//  RACViewController.h
//  MarkeJave
//
//  Created by MarkeJave on 14/12/27.
//  Copyright (c) 2014年 MarkeJave. All rights reserved.
//

#import "RACControllerViewModel.h"

@protocol RACViewControllerProtocol <NSObject>

/// The `viewModel` parameter in `-initWithViewModel:` method.
@property (nonatomic, strong) RACControllerViewModel *viewModel;

/// Initialization method. This is the preferred way to create a new view.
///
/// viewModel - corresponding view model
///
/// Returns a new view.
- (instancetype)initWithViewModel:(RACControllerViewModel *)viewModel;

/// Binds the corresponding view model to the view.
- (void)bindViewModel;

@end

@interface UIViewController (RACInitialization)

/// The `viewModel` parameter in `-initWithViewModel:` method.
@property (nonatomic, strong, readonly) RACControllerViewModel *viewModel;

/// Initialization method. This is the preferred way to create a new view.
///
/// viewModel - corresponding view model
///
/// Returns a new view.
- (instancetype)initWithViewModel:(RACControllerViewModel *)viewModel;

/// Binds the corresponding view model to the view.
- (void)bindViewModel;

@end