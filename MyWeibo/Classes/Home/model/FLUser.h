//
//  FLUser.h
//  MyWeibo
//
//  Created by asddfg on 16/2/27.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLUser : NSObject
/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  微博图像
 */
@property (nonatomic, copy) NSURL *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;


@property (nonatomic, assign,getter=isVip) BOOL vip;



@end
