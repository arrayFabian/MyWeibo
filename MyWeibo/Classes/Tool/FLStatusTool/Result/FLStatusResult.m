//
//  FLStatusResult.m
//  MyWeibo
//
//  Created by asddfg on 16/2/28.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLStatusResult.h"
#import "FLStatus.h"

@implementation FLStatusResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses":[FLStatus class]};
}

@end
