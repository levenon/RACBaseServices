//
//  RACReactiveViewModel.m
//  UDrivingCustomer
//
//  Created by Marke Jave on 16/5/13.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import "RACReactiveViewModel.h"

@implementation RACReactiveViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    RACReactiveViewModel *viewModel = [super allocWithZone:zone];
    [[viewModel rac_signalForSelector:@selector(init)] subscribeNext:^(id x) {
        [viewModel initialize];
    }];
    return viewModel;
}

- (void)initialize{
}

@end
