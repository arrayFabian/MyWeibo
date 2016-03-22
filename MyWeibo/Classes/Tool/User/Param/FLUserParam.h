//
//  FLUserParam.h
//  MyWeibo
//
//  Created by asddfg on 16/2/29.
//  Copyright © 2016年 fabian. All rights reserved.
//  用户未读数的

#import <Foundation/Foundation.h>
#import "FLBaseParam.h"

@interface FLUserParam : FLBaseParam

/**
*  当前登录用户唯一标示符
*/
@property (nonatomic, copy) NSString *uid;


@end
