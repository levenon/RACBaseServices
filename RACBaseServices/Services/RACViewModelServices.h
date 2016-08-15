//
//  RACControllerViewModelServices.h
//  UDrivingCustomer
//
//  Created by MarkeJave on 14/12/27.
//  Copyright (c) 2014年 MarkeJave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACNavigationProtocol.h"
#import "RACAppStoreService.h"

@protocol RACViewModelServices <NSObject, RACNavigationProtocol>

@optional
@property (nonatomic, strong, readonly) id<RACAppStoreService> appStoreService;

@end
