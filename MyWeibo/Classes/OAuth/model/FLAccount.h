//
//  FLAccount.h
//  MyWeibo
//
//  Created by asddfg on 16/2/26.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "access_token" = "2.00k5S3uB6D1HEB4db658dcd8HDfj5E";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 1748921590;
 */

@interface FLAccount : NSObject<NSCoding>
/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  账号有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  过期时间
 */
@property (nonatomic, strong) NSDate *expires_date;

@property (nonatomic, copy) NSString *remind_in;
/**
 *  用户标示符
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)acoountWithDict:(NSDictionary *)dict;

@end
