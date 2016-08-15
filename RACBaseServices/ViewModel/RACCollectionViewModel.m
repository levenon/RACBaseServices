//
//  RACControllerViewModel.m
//  Grandway
//
//  Created by xulinfeng on 16/7/2.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import "RACCollectionViewModel.h"

@interface RACCollectionViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation RACCollectionViewModel

- (instancetype)initWithServices:(id<RACViewModelServices>)services params:(NSDictionary *)params{
    self = [super initWithServices:services params:params];
    if (self) {
        self.page = 1;
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
    
    self.collectionViewLayout = [self defaultCollectionViewLayout];
}

- (UICollectionViewFlowLayout *)defaultCollectionViewLayout{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) / 3 ,
                                       CGRectGetWidth([[UIScreen mainScreen] bounds]) / 3)];
    [flowLayout setMinimumLineSpacing:0];
    [flowLayout setMinimumInteritemSpacing:0];
    return flowLayout;
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
    return (page - 1) * self.perPage;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}


@end
