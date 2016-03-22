//
//  FLUserTool.m
//  MyWeibo
//
//  Created by asddfg on 16/2/29.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLUserTool.h"
#import "FLUserParam.h"
#import "FLUserResult.h"
#import "FLUser.h"

#import "FLHttpTool.h"

#import "FLAccountTool.h"
#import "FLAccount.h"
#import <MJExtension/MJExtension.h>


@implementation FLUserTool

+ (void)unreadWithSuccess:(void (^)(FLUserResult *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    FLUserParam *param = [FLUserParam param];
    param.uid = [FLAccountTool account].uid;
    
    //网络请求
   [ FLHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.mj_keyValues success:^(id responseObject) {
       //字典转模型
       FLUserResult *result = [FLUserResult mj_objectWithKeyValues:responseObject];
       
       if (success) {
           success(result);
       }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}

+ (void)userInfoWithSuccess:(void (^)(FLUser *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    FLUserParam *param = [FLUserParam param];
    param.uid = [FLAccountTool account].uid;
    
    [FLHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.mj_keyValues success:^(id responseObject) {
        //用户字典转用户模型
        FLUser *user = [FLUser mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}

@end
