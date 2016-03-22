//
//  FLBaseParam.h
//  MyWeibo
//
//  Created by asddfg on 16/2/29.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLBaseParam : NSObject
/**
 *  access_token
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end
