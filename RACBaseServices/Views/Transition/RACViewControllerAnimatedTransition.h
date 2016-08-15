//
//  RACViewControllerAnimatedTransition.h
//  MarkeJave
//
//  Created by MarkeJave on 15/12/8.
//  Copyright © 2015年 MarkeJave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RACViewControllerAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) UINavigationControllerOperation operation;
@property (nonatomic, weak, readonly) UIViewController *fromViewController;
@property (nonatomic, weak, readonly) UIViewController *toViewController;

- (instancetype)initWithNavigationControllerOperation:(UINavigationControllerOperation)operation
                                   fromViewController:(UIViewController *)fromViewController
                                     toViewController:(UIViewController *)toViewController;

@end

@interface UIViewController (RACViewControllerAnimatedTransition)

@property (nonatomic, strong) UIView *snapshot;

@property (nonatomic, strong, readonly) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end