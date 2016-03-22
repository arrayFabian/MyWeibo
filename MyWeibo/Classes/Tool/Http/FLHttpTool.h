//
//  FLHttpTool.h
//  MyWeibo
//
//  Created by asddfg on 16/2/28.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLUploadParam;
@interface FLHttpTool : NSObject

/**
 *  get请求
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  post请求
 */
+ (void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  post请求
 */
+ (void)Upload:(NSString *)URLString
  parameters:(id)parameters
   uploadParam:(FLUploadParam *)uploadParam
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;




@end
