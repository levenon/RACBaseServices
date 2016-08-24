//
//  BaseViewController.m
//  RACBaseServiceDemo
//
//  Created by dihong on 16/8/24.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import "BaseViewController.h"
#import <RACBaseServices/RACBaseServices.h>

@interface BaseViewController ()

@property (nonatomic, strong) RACControllerViewModel *viewModel;

@end

@implementation BaseViewController
@dynamic viewModel;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController bindViewModel];
    }];
    return viewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self viewModel] willAppearSignal] sendNext:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[[self viewModel] didAppearSignal] sendNext:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self view] endEditing:YES];
    [[[self viewModel] willDisappearSignal] sendNext:nil];
    // Being popped, take a snapshot
    if ([self isMovingFromParentViewController]) {
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[[self viewModel] didDisappearSignal] sendNext:nil];
}

@end