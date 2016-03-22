//
//  FLStatusTool.h
//  MyWeibo
//
//  Created by asddfg on 16/2/28.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLStatusTool : NSObject
/**
 * 请求更新的微博数据
 sinceId：返回比这个更大的微博数据
 success：请求成功的时候回调(statuses(CZStatus模型))
 failure:请求失败的时候回调，错误传递给外界
 
 */
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

/**
 * 请求更多的微博数据
 maxId：返回小于等于这个ID的微博数据
 success：请求成功的时候回调(statuses(CZStatus模型))
 failure:请求失败的时候回调，错误传递给外界
 
 */
+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

@end
