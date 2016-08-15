//
//  RACTableViewModel.m
//  MarkeJave
//
//  Created by MarkeJave on 14/12/27.
//  Copyright (c) 2014年 MarkeJave. All rights reserved.
//

#import "RACTableViewModel.h"

@interface RACTableViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation RACTableViewModel

- (instancetype)initWithServices:(id<RACViewModelServices>)services params:(NSDictionary *)params{
    self = [super initWithServices:services params:params];
    if (self) {
        self.page = 0;
        self.perPage = 10;
    }
    return self;
}

- (void)initialize {
    [super initialize];
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *page) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:[page unsignedIntegerValue]] takeUntil:[self rac_willDeallocSignal]];
    }];
    [[self.requestRemoteDataCommand.errors filter:[self requestRemoteDataErrorsFilter]] subscribe:[self errors]];
}

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter {
    return ^(NSError *error) {
        return YES;
    };
}

- (id)fetchLocalData {
    return nil;
}

- (NSUInteger)offsetForPage:(NSUInteger)page {
    return page * self.perPage;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

@end
