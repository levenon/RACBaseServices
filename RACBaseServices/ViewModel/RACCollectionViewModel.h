//
//  RACControllerViewModel.h
//  Grandway
//
//  Created by xulinfeng on 16/7/2.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import "RACControllerViewModel.h"

@interface RACCollectionViewModel : RACControllerViewModel

/// The data source of table view.
@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger perPage;

@property (nonatomic, assign) BOOL shouldPullToRefresh;
@property (nonatomic, assign) BOOL shouldInfiniteScrolling;

@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, strong) RACCommand *didSelectCommand;
@property (nonatomic, strong, readonly) RACCommand *requestRemoteDataCommand;

- (id)fetchLocalData;

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter;

- (NSUInteger)offsetForPage:(NSUInteger)page;

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end
