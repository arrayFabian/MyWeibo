//
//  FLUser.m
//  MyWeibo
//
//  Created by asddfg on 16/2/27.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLUser.h"

@implementation FLUser
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
