//
//  FLUploadParam.h
//  MyWeibo
//
//  Created by asddfg on 16/3/15.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLUploadParam : NSObject

/**
 *  fileData : 要上传的二进制数据
 *
 *  name :上传参数的名称
 *
 *  fileName 上传到服务器的名称
 *  mimeType: 文件类型
 */

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, copy) NSString *mimeType;

@property (nonatomic, strong) NSData *data;

@end
