//
//  RACAppStoreService.h
//  MarkeJave
//
//  Created by MarkeJave on 15/3/6.
//  Copyright (c) 2015年 MarkeJave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol RACAppStoreService <NSObject>

- (RACSignal *)requestAppInfoFromAppStoreWithAppID:(NSString *)appID;

@end
