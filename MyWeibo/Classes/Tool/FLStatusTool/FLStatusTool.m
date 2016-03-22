//
//  FLStatusTool.m
//  MyWeibo
//
//  Created by asddfg on 16/2/28.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLStatusTool.h"

#import "FLStatus.h"
#import "FLAccountTool.h"
#import "FLAccount.h"
#import "FLHttpTool.h"
#import "FLStatusParam.h"
#import "FLStatusResult.h"
#import <MJExtension.h>


@implementation FLStatusTool

+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    FLStatusParam *param = [[FLStatusParam alloc]init];
    
    param.access_token = [FLAccountTool account].access_token;
    
    param.max_id = maxId;
   
    
    //发送GET请求
    //使用自己封装的http工具类
    [FLHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {

        //数据转换成模型
        FLStatusResult *result = [FLStatusResult mj_objectWithKeyValues:responseObject];
        
//        NSArray *dictArr = responseObject[@"statuses"];
//        NSArray *statuses = [FLStatus mj_objectArrayWithKeyValuesArray:dictArr];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    
    //创建参数模型
    FLStatusParam *param = [[FLStatusParam alloc]init];
    
    param.access_token = [FLAccountTool account].access_token;

    param.since_id = sinceId;
    
    //发送GET请求
    //使用自己封装的http工具类
    [FLHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {
        //数据转换成模型
        FLStatusResult *result = [FLStatusResult mj_objectWithKeyValues:responseObject];

//        NSArray *dictArr = responseObject[@"statuses"];
//        NSArray *statuses = [FLStatus mj_objectArrayWithKeyValuesArray:dictArr];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];


}

@end
