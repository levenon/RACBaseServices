//
//  RACNavigationControllerStack.h
//  MarkeJave
//
//  Created by MarkeJave on 15/1/10.
//  Copyright (c) 2015年 MarkeJave. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RACViewModelServices;

@interface RACNavigationControllerStack : NSObject

@property (nonatomic, strong, readonly) NSArray *viewControllers;

/// Initialization method. This is the preferred way to create a new navigation controller stack.
///
/// services - The service bus of the `Model` layer.
///
/// Returns a new navigation controller stack.
- (instancetype)initWithServices:(NSObject<RACViewModelServices> *)services;

/// Pushes the navigation controller.
///
/// navigationController - the navigation controller
- (void)pushNavigationController:(UINavigationController *)navigationController;

/// present the view controller.
///
/// viewController - the view controller
- (void)presentViewController:(UIViewController *)viewController;

/// Pops the top navigation controller in the stack.
///
/// Returns the popped navigation controller.
- (UINavigationController *)popNavigationController;

/// dissmiss the presenting view controller in the stack if the top controller isn't navigation controller,
/// or pop the top navigation controller.
///
/// Returns the dissmiss presenting view controller.
- (UIViewController *)dismissPresentingViewController;

/// Retrieves the top navigation controller in the stack.
///
/// Returns the top navigation controller in the stack.
- (UINavigationController *)topNavigationController;

/// Retrieves the top view controller in the stack. maybe navigation controller.
///
/// Returns the top view controller in the stack.
- (UIViewController *)topViewController;

/// Retrieves the visiable view controller in the stack. maybe navigation controller.
///
/// Returns the visiable view controller in the stack.
- (UIViewController *)visibleViewController;

@end
