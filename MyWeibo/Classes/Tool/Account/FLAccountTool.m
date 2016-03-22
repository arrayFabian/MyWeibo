//
//  FLAccountTool.m
//  MyWeibo
//
//  Created by Mac on 16/2/27.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLAccountTool.h"
#import "FLAccount.h"
#import "FLAccountParam.h"

#import <MJExtension/MJExtension.h>
#import "FLHttpTool.h"
#import <AFNetworking/AFNetworking.h>

#define FLAccountFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

#define AppKey @"976983563"
#define AppSecret @"8e39c9ca66ae57caa847f38630571e3c"


@implementation FLAccountTool
//类方法一般用静态变量代替成员属性
static FLAccount *_account;

+ (void)saveAccount:(FLAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:FLAccountFilePath];
}

+ (FLAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:FLAccountFilePath];
    }
    //判断是否过期
    if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {// 递减 过期，重新授权
        
        return nil;
    }
   
    return _account;
    
}

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    FLAccountParam *param = [[FLAccountParam alloc]init];
    
    param.client_id = AppKey;
    param.client_secret = AppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = @"http://www.baidu.com";
    
    [FLHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.mj_keyValues
   success:^(id responseObject) {
       //字典转模型
       FLAccount *account = [FLAccount acoountWithDict:responseObject];
       //保存账号信息
       //开发一个业务类，专门处理数据存储
       //可以换成数据库
       [FLAccountTool saveAccount:account];
       if (success) {
           success();
       }
       
   } failure:^(NSError *error) {
       if (failure) {
           failure(error);
       }
       
   }];
    
}

@end
