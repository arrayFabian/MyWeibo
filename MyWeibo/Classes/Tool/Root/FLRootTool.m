//
//  FLRootTool.m
//  MyWeibo
//
//  Created by Mac on 16/2/27.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLRootTool.h"
#define FLVersionKey @"Version"
#import "FLTabbarController.h"
#import "FLNewFeatureController.h"

@implementation FLRootTool

+ (void)chooseRootViewController:(UIWindow *)window
{
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:FLVersionKey];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //判断是否是新版本
    if ([currentVersion isEqual:oldVersion]) {//相同版本
        
        FLTabbarController *tabbarVc = [[FLTabbarController alloc]init];
        
        window.rootViewController = tabbarVc;
        
    }else{//新版本
        
        FLNewFeatureController *vc = [[FLNewFeatureController alloc] init];
        
        window.rootViewController = vc;
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:FLVersionKey];
        
    }
    
}

@end
