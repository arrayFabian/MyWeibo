//
//  FLAccountTool.h
//  MyWeibo
//
//  Created by Mac on 16/2/27.
//  Copyright © 2016年 fabian. All rights reserved.
//  专门用来处理账号业务：存储和读取

#import <Foundation/Foundation.h>

@class FLAccount;
@interface FLAccountTool : NSObject

+ (void)saveAccount:(FLAccount *)account;

+ (FLAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
