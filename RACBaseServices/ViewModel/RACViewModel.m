//
//  RACViewModel.m
//  UDrivingCustomer
//
//  Created by Marke Jave on 16/5/3.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import "RACViewModel.h"

@interface RACViewModel ()

@property (nonatomic, strong) RACSubject *errors;

@property (nonatomic, strong) NSMutableDictionary *keyPathAndValues;

@end

@implementation RACViewModel

- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}

- (NSMutableDictionary *)keyPathAndValues{
    if (!_keyPathAndValues) {
        _keyPathAndValues = [NSMutableDictionary dictionary];
    }
    return _keyPathAndValues;
}

@end
