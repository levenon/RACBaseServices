//
//  RootViewModel.m
//  RACBaseServiceDemo
//
//  Created by dihong on 16/8/24.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import "RootViewModel.h"
#import "RootViewController.h"
#import "NextViewModel.h"

@interface RootViewModel ()

@property (nonatomic, strong) RACCommand *pushCommand;

@end

@implementation RootViewModel

- (instancetype)initWithServices:(id<RACViewModelServices>)services params:(NSDictionary *)params{
    if (self = [super initWithServices:services params:params]){
        self.title = @"root";
    }
    return self;
}

- (void)initialize{
    [super initialize];
    
    @weakify(self);
    self.pushCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        NextViewModel *nextViewModel = [[NextViewModel alloc] initWithServices:[self services] params:@{@"title":@"next"}];
        [[self services] pushViewModel:nextViewModel animated:YES];
        
        return [RACSignal empty];
    }];
}

- (Class)viewControllerClass{
    return [RootViewController class];
}

@end
