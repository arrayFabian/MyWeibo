//
//  FLStatus.m
//  MyWeibo
//
//  Created by asddfg on 16/2/27.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLStatus.h"
#import "FLPhoto.h"
#import "NSDate+MJ.h"
#import "FLUser.h"

@implementation FLStatus
// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls":[FLPhoto class]};
}


- (void)setRetweeted_status:(FLStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    _retweetedName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}

- (NSString *)created_at
{
   // NSLog(@"%@",_created_at);
    //Fri Mar 11 15:25:02 +0800 2016
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    
    if ([created_at isThisYear]) {//今年
        
        if ([created_at isToday]) {//今天
            
            //计算跟当前时间的差距
            NSDateComponents *cmp = [created_at deltaWithNow];
         //   NSLog(@"%ld--%ld--%ld",cmp.hour,cmp.minute,cmp.second);
            
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            }else{
                return @"刚刚";
            }
            
            
        }else if ([created_at isYesterday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:created_at];
            
            
        }else{//前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:created_at];
            
        }
        
    }else{//不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    
    
    return _created_at;
}


- (void)setSource:(NSString *)source
{
    //<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
   // NSLog(@"%@",source);

    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自%@",source];
   // NSLog(@"%@",source);
    
       _source = source;
}

@end
