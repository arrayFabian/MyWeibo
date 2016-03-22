//
//  FLComposeTool.h
//  MyWeibo
//
//  Created by asddfg on 16/3/15.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLComposeTool : NSObject

//https://api.weibo.com/2/statuses/update.json

+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;


//https://upload.api.weibo.com/2/statuses/upload.json

+ (void)composeWithStatus:(NSString *)status picture:(UIImage *)image success:(void(^)())success failure:(void(^)(NSError *error))failure;


@end
