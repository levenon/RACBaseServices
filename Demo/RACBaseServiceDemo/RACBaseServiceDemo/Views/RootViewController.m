//
//  RootViewController.m
//  RACBaseServiceDemo
//
//  Created by dihong on 16/8/24.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import "RootViewController.h"
#import <RACBaseServices/RACBaseServices.h>
#import "RootViewModel.h"

@interface RootViewController ()

@property (nonatomic, strong) UIButton *pushButton;

@property (nonatomic, strong, readonly) RootViewModel *viewModel;

@end

@implementation RootViewController
@dynamic viewModel;

- (instancetype)initWithViewModel:(RootViewModel *)viewModel{
    if (self = [super initWithViewModel:viewModel]) {
        [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
            // Do something
            
        }];
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [[self view] addSubview:[self pushButton]];
}

- (void)bindViewModel{
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve([self viewModel], buttonTitle) subscribeNext:^(NSString *title) {
        @strongify(self);
        [[self pushButton] setTitle:title forState:UIControlStateNormal];
    }];
    
    [[[self pushButton] rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [[[self viewModel] pushCommand] execute:nil];
    }];
    
    //    or
    //    self.pushButton.rac_command = self.viewModel.pushCommand
}

#pragma mark - accessor

- (UIButton *)pushButton{
    if (!_pushButton) {
        _pushButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, 200, 50)];
        _pushButton.backgroundColor = [UIColor blueColor];
    }
    return _pushButton;
}

@end
