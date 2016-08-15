//
//  RACNavigationProtocol.h
//  MarkeJave
//
//  Created by MarkeJave on 15/1/10.
//  Copyright (c) 2015年 MarkeJave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACControllerProtocol.h"

@protocol RACNavigationProtocol <RACControllerProtocol>

/// Pushes the corresponding view controller.
///
/// Uses a horizontal slide transition.
/// Has no effect if the corresponding view controller is already in the stack.
///
/// viewModel - the view model
/// animated  - use animation or not
- (void)pushViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated;
- (void)pushViewModelToBeRootViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated;
- (void)pushViewModel:(RACControllerViewModel *)viewModel followByViewModel:(RACControllerViewModel *)followByViewModel animated:(BOOL)animated;
- (void)pushViewModel:(RACControllerViewModel *)viewModel replaceViewModel:(RACControllerViewModel *)replaceViewModel animated:(BOOL)animated;

/// Pops the top view controller in the stack.
///
/// animated - use animation or not
- (void)popViewModelAnimated:(BOOL)animated;
- (void)popViewModelAnimated:(BOOL)animated completeBlock:(void(^)(id<RACNavigationProtocol> navgation))completeBlock;

/// Pops until there's only a single view controller left on the stack.
///
/// animated - use animation or not
- (void)popToRootViewModelAnimated:(BOOL)animated;
- (void)popToRootViewModelAnimated:(BOOL)animated completeBlock:(void(^)(id<RACNavigationProtocol> navgation))completeBlock;

- (void)popToViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated completeBlock:(void(^)(id<RACNavigationProtocol> navgation))completeBlock;

/// Reset the corresponding view controller as the root view controller of the application's window.
///
/// viewModel - the view model
- (void)resetRootViewModel:(RACControllerViewModel *)viewModel;
- (void)resetRootNavigationWithViewModel:(RACControllerViewModel *)viewModel;

@end
