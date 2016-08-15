//
//  RACTableViewModel.h
//  MarkeJave
//
//  Created by MarkeJave on 14/12/27.
//  Copyright (c) 2014年 MarkeJave. All rights reserved.
//

#import "RACControllerViewModel.h"

@interface RACTableViewModel : RACControllerViewModel

/// The data source of table view.
@property (nonatomic, copy) NSArray *dataSource;

/// The list of section titles to display in section index view.
@property (nonatomic, copy) NSArray *sectionIndexTitles;

@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger perPage;

@property (nonatomic, assign) BOOL needPullToRefresh;
@property (nonatomic, assign) BOOL shouldPullToRefresh;
@property (nonatomic, assign) BOOL shouldInfiniteScrolling;

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, strong) RACCommand *didSelectCommand;
@property (nonatomic, strong, readonly) RACCommand *requestRemoteDataCommand;

- (id)fetchLocalData;

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter;

- (NSUInteger)offsetForPage:(NSUInteger)page;

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end
