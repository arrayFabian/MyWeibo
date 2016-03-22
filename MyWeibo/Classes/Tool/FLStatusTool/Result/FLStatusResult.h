//
//  FLStatusResult.h
//  MyWeibo
//
//  Created by asddfg on 16/2/28.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@interface FLStatusResult : NSObject<MJKeyValue>
/**
 *  微博数组
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近微博数
 */
@property (nonatomic, assign) NSNumber *total_number;

@end
