//
//  FLUserResult.m
//  MyWeibo
//
//  Created by asddfg on 16/2/29.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLUserResult.h"

@implementation FLUserResult

- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totalCount
{
    return _cmt + _dm + _mention_cmt + _mention_status + _status + _follower;
}

@end
