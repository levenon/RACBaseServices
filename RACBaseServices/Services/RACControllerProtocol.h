//
//  RACControllerProtocol.h
//  UDrivingCustomer
//
//  Created by Marke Jave on 16/5/3.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACControllerViewModel;
@protocol RACControllerProtocol <NSObject>

/// Present the corresponding view controller.
///
/// viewModel  - the view model
/// animated   - use animation or not
/// completion - the completion handler
- (void)presentViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated completion:(void (^)())completion;

/// Present the corresponding view controller with auto-create navigation controller.
///
/// viewModel  - the view model
/// animated   - use animation or not
/// completion - the completion handler
- (void)presentNavigationWithRootViewModel:(RACControllerViewModel *)viewModel animated:(BOOL)animated completion:(void (^)())completion;

/// Dismiss the presented view controller.
///
/// animated   - use animation or not
/// completion - the completion handler
- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^)())completion;

@end
