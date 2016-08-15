//
//  RACControllerViewModel.h
//  MarkeJave
//
//  Created by MarkeJave on 14/12/27.
//  Copyright (c) 2014年 MarkeJave. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RACViewModel.h"
#import "RACViewModelServices.h"

extern NSString * const RACControllerViewModelTitleKey;

/// The type of the title view.
typedef NS_ENUM(NSUInteger, RACTitleViewType) {
    /// System title view
    RACTitleViewTypeDefault,
    /// Double title view
    RACTitleViewTypeDoubleTitle,
    /// Loading title view
    RACTitleViewTypeLoadingTitle
};

/// An abstract class representing a view model.
@interface RACControllerViewModel : RACViewModel

/// Initialization method. This is the preferred way to create a new view model.
///
/// services - The service bus of the `Model` layer.
/// params   - The parameters to be passed to view model.
///
/// Returns a new view model.
- (instancetype)initWithServices:(id<RACViewModelServices>)services params:(NSDictionary *)params;

/// The `services` parameter in `-initWithServices:params:` method.
@property (nonatomic, strong, readonly) id<RACViewModelServices> services;

/// The `params` parameter in `-initWithServices:params:` method.
@property (nonatomic, copy  , readonly) NSDictionary *params;

@property (nonatomic, assign) RACTitleViewType titleViewType;

@property (nonatomic, assign) BOOL hidesBackButton;

@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *subtitle;

@property (nonatomic, strong, readonly) Class viewControllerClass;

/// The callback block.
@property (nonatomic, copy) void (^callback)(id obj);

@property (nonatomic, assign) BOOL shouldFetchLocalDataOnViewModelInitialize;
@property (nonatomic, assign) BOOL shouldRequestRemoteDataOnViewDidLoad;

@property (nonatomic, strong, readonly) RACSubject *willAppearSignal;

@property (nonatomic, strong, readonly) RACSubject *didAppearSignal;

@property (nonatomic, strong, readonly) RACSubject *willDisappearSignal;

@property (nonatomic, strong, readonly) RACSubject *didDisappearSignal;

/// An additional method, in which you can initialize data, RACCommand etc.
///
/// This method will be execute after the execution of `-initWithServices:params:` method. But
/// the premise is that you need to inherit `RACControllerViewModel`.
- (void)initialize;

- (void)popBackViewModel;
- (void)popBackToRootViewModel;
- (void)dismissBackViewModel:(void (^)())completion;

@end
