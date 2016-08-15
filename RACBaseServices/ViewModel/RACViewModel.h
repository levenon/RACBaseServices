//
//  RACViewModel.h
//  UDrivingCustomer
//
//  Created by Marke Jave on 16/5/3.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACViewModel : NSObject

/// A RACSubject object, which representing all errors occurred in view model.
@property (nonatomic, strong, readonly) RACSubject *errors;

@property (nonatomic, strong, readonly) NSMutableDictionary *keyPathAndValues;

@end
