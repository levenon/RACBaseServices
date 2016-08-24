//
//  RootViewModel.h
//  RACBaseServiceDemo
//
//  Created by dihong on 16/8/24.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import <RACBaseServices/RACBaseServices.h>

@interface RootViewModel : RACControllerViewModel

@property (nonatomic, strong, readonly) RACCommand *pushCommand;

@end
