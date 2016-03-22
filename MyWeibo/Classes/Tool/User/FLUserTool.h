//
//  FLUserTool.h
//  MyWeibo
//
//  Created by asddfg on 16/2/29.
//  Copyright © 2016年 fabian. All rights reserved.
//  处理用户的未读数据业务

#import <Foundation/Foundation.h>
@class FLUserResult,FLUser;
@interface FLUserTool : NSObject

/**
 *  请求用户的未读数
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(FLUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(FLUser *user))success failure:(void(^)(NSError *error))failure;


@end
