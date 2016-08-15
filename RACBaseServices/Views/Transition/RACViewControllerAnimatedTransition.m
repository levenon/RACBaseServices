//
//  RACViewControllerAnimatedTransition.m
//  MarkeJave
//
//  Created by MarkeJave on 15/12/8.
//  Copyright © 2015年 MarkeJave. All rights reserved.
//

#import "RACViewControllerAnimatedTransition.h"
#import "RACViewController.h"
#import "RACControllerViewModel.h"

#import <objc/runtime.h>

@interface RACViewControllerAnimatedTransition ()

@property (nonatomic, assign, readwrite) UINavigationControllerOperation operation;
@property (nonatomic, weak, readwrite) UIViewController *fromViewController;
@property (nonatomic, weak, readwrite) UIViewController *toViewController;

@end

@implementation RACViewControllerAnimatedTransition

- (instancetype)initWithNavigationControllerOperation:(UINavigationControllerOperation)operation
                                   fromViewController:(UIViewController *)fromViewController
                                     toViewController:(UIViewController *)toViewController {
    self = [super init];
    if (self) {
        self.operation = operation;
        self.fromViewController = fromViewController;
        self.toViewController = toViewController;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    if (self.operation == UINavigationControllerOperationPush) { // push
        [[transitionContext containerView] addSubview:fromViewController.snapshot];
        fromViewController.view.hidden = YES;
        CGRect frame = [transitionContext finalFrameForViewController:toViewController];
        toViewController.view.frame = CGRectOffset(frame, CGRectGetWidth(frame), 0);
        [[transitionContext containerView] addSubview:toViewController.view];

        [UIView animateWithDuration:duration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             fromViewController.snapshot.alpha = 0.0;
                             fromViewController.snapshot.frame = CGRectInset(fromViewController.view.frame, 20, 20);
                             toViewController.view.frame = CGRectOffset(toViewController.view.frame, -CGRectGetWidth(toViewController.view.frame), 0);
                         }
                         completion:^(BOOL finished) {
                             fromViewController.view.hidden = NO;
                             [fromViewController.snapshot removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
    } else if (self.operation == UINavigationControllerOperationPop) { // pop
        UIApplication.sharedApplication.delegate.window.backgroundColor = [UIColor blackColor];
        [fromViewController.view addSubview:fromViewController.snapshot];
        fromViewController.navigationController.navigationBar.hidden = YES;
        toViewController.view.hidden = YES;
        toViewController.snapshot.alpha = 0.5;
        toViewController.snapshot.transform = CGAffineTransformMakeScale(0.95, 0.95);
        [[transitionContext containerView] addSubview:toViewController.view];
        [[transitionContext containerView] addSubview:toViewController.snapshot];
        [[transitionContext containerView] sendSubviewToBack:toViewController.snapshot];
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             fromViewController.view.frame = CGRectOffset(fromViewController.view.frame, CGRectGetWidth(fromViewController.view.frame), 0);
                             toViewController.snapshot.alpha = 1.0;
                             toViewController.snapshot.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             UIApplication.sharedApplication.delegate.window.backgroundColor = [UIColor whiteColor];
                             
                             toViewController.navigationController.navigationBar.hidden = NO;
                             toViewController.view.hidden = NO;
                             
                             [fromViewController.snapshot removeFromSuperview];
                             [toViewController.snapshot removeFromSuperview];
                             
                             // Reset toViewController's `snapshot` to nil
                             if (![transitionContext transitionWasCancelled]) {
                                 toViewController.snapshot = nil;
                             }
                             
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
}

@end

@interface UIViewController (RACViewControllerAnimatedTransition_Private)

@property (nonatomic, strong, readwrite) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation UIViewController (RACViewControllerAnimatedTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL sel1 = NSSelectorFromString(@"viewWillDisappear:");
        SEL sel2 = NSSelectorFromString(@"rac_viewWillDisappear:");
        Method m1 = class_getInstanceMethod(class, sel1);
        Method m2 = class_getInstanceMethod(class, sel2);
        IMP imp1 = class_getMethodImplementation(class, sel1);
        if (imp1 != NULL) {
            method_exchangeImplementations(m1, m2);
        }
    });
}

- (void)rac_viewWillDisappear:(BOOL)animated {
    [self rac_viewWillDisappear:animated];
    [self.viewModel.willDisappearSignal sendNext:nil];
    // Being popped, take a snapshot
    if ([self isMovingFromParentViewController]) {
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
}

- (UIView *)snapshot{
    return objc_getAssociatedObject(self, @selector(snapshot));
}

- (void)setSnapshot:(UIView *)snapshot{
    if ([self snapshot] != snapshot) {
        objc_setAssociatedObject(self, @selector(snapshot), snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIPercentDrivenInteractiveTransition *)interactivePopTransition{
    return objc_getAssociatedObject(self, @selector(interactivePopTransition));
}

- (void)setInteractivePopTransition:(UIPercentDrivenInteractiveTransition *)interactivePopTransition{
    if ([self interactivePopTransition] != interactivePopTransition) {
        objc_setAssociatedObject(self, @selector(interactivePopTransition), interactivePopTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
