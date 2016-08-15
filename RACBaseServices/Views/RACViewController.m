//
//  RACViewController.m
//  MarkeJave
//
//  Created by MarkeJave on 14/12/27.
//  Copyright (c) 2014年 MarkeJave. All rights reserved.
//

#import <objc/runtime.h>

#import "RACViewController.h"
#import "RACDoubleTitleView.h"
#import "RACLoadingTitleView.h"

@interface UIViewController (RACInitialization_Private)<RACViewControllerProtocol>

@end

@implementation UIViewController (RACInitialization)

- (RACControllerViewModel *)viewModel{
    return objc_getAssociatedObject(self, @selector(viewModel));
}

- (void)setViewModel:(RACControllerViewModel *)viewModel{
    if ([self viewModel] != viewModel) {
        objc_setAssociatedObject(self, @selector(viewModel), viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (instancetype)initWithViewModel:(RACControllerViewModel *)viewModel {
    self = [self init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)bindViewModel {
    
    [[[self viewModel] keyPathAndValues] enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL * _Nonnull stop) {
        [self setValue:value forKeyPath:key];
    }];
    
    RAC([self navigationItem], hidesBackButton) = RACObserve([self viewModel], hidesBackButton);
    // System title view
    RAC(self, title) = RACObserve([self viewModel], title);
    UIView *titleView = [[self navigationItem] titleView];
    // Double title view
    RACDoubleTitleView *doubleTitleView = [[RACDoubleTitleView alloc] initWithFrame:CGRectZero];
    RAC([doubleTitleView titleLabel], text)    = RACObserve([self viewModel], title);
    RAC([doubleTitleView subtitleLabel], text) = RACObserve([self viewModel], subtitle);
    @weakify(self)
    [[self rac_signalForSelector:@selector(viewWillTransitionToSize:withTransitionCoordinator:)] subscribeNext:^(id x) {
        @strongify(self)
        [doubleTitleView titleLabel].text    = [[self viewModel] title];
        [doubleTitleView subtitleLabel].text = [[self viewModel] subtitle];
    }];
    // Loading title view
    RACLoadingTitleView *loadingTitleView = [[RACLoadingTitleView alloc] initWithFrame:CGRectZero];
    RAC([self navigationItem], titleView) = [[RACObserve([self viewModel], titleViewType) distinctUntilChanged] map:^(NSNumber *value) {
        RACTitleViewType titleViewType = value.unsignedIntegerValue;
        switch (titleViewType) {
            case RACTitleViewTypeDefault:
                return titleView;
            case RACTitleViewTypeDoubleTitle:
                return (UIView *)doubleTitleView;
            case RACTitleViewTypeLoadingTitle:
                return (UIView *)loadingTitleView;
        }
    }];
}

@end
