//
//  FLBaseParam.m
//  MyWeibo
//
//  Created by asddfg on 16/2/29.
//  Copyright © 2016年 fabian. All rights reserved.
//  基本的参数模型

#import "FLBaseParam.h"
#import "FLAccount.h"
#import "FLAccountTool.h"

@implementation FLBaseParam

+ (instancetype)param
{
    FLBaseParam *param = [[self alloc] init];
    
    param.access_token = [FLAccountTool account].access_token;
    
    return param;
}

@end
