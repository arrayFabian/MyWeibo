//
//  FLComposeTool.m
//  MyWeibo
//
//  Created by asddfg on 16/3/15.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLComposeTool.h"
#import "FLHttpTool.h"
#import "FLComposeParam.h"
#import <MJExtension/MJExtension.h>

#import "FLUploadParam.h"

@implementation FLComposeTool

+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    FLComposeParam *param = [FLComposeParam param];
    param.status = status;
    
    [FLHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.mj_keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

/**
 *  发送微博图片
 *
 *  @param status  微博内容
 *  @param image   图片
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)composeWithStatus:(NSString *)status picture:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    FLComposeParam *param = [FLComposeParam param];
    param.status = status;
    
    FLUploadParam *uploadParam = [[FLUploadParam alloc]init];
    uploadParam.name = @"pic";
    uploadParam.fileName = @"image.png";
    uploadParam.mimeType = @"image/png";
    uploadParam.data = UIImagePNGRepresentation(image);
   
   
    
    [FLHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.mj_keyValues
    uploadParam:uploadParam  success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

  
}


@end
