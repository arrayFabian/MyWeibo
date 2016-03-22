//
//  FLStatusFrame.m
//  MyWeibo
//
//  Created by asddfg on 16/3/10.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLStatusFrame.h"
#import "FLStatus.h"
#import "FLUser.h"



@implementation FLStatusFrame

- (void)setStatus:(FLStatus *)status
{
    _status = status;
    
    //计算原创微博Frame
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
   // NSLog(@"%f",toolBarY);
    
    if (status.retweeted_status) {
        //计算转发微博Frame
        [self setUpRetweetViewFrame];
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
       //  NSLog(@"%f",toolBarY);
    }
    
    //计算toolBar Frame
    CGFloat toolBarX = 0;
    CGFloat toolBarW = FLAppScreenWidth;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    //计算cell 高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}

#pragma mark- 计算原创微博Frame
- (void)setUpOriginalViewFrame
{
    //头像
    CGFloat iconX = FLCellMargin;
    CGFloat iconY = iconX;
    CGFloat iconWH = 35;
    _originalIconViewFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconViewFrame) + FLCellMargin;
    CGFloat nameY = iconY;
    CGSize size = [_status.user.name sizeWithFont:FLCellNameFont];
    _originalNameViewFrame = (CGRect){{nameX,nameY},size};
    
    //VIP
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameViewFrame) + FLCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipViewFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
     
    }
    
    //时间frame每次得重新计算 来源依赖于时间的frame  在每次得到是时候计算

    //正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_originalIconViewFrame) + FLCellMargin;
    CGFloat textW = FLAppScreenWidth - FLCellMargin * 2;
    CGSize textSize = [_status.text sizeWithFont:FLCellTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextViewFrame = (CGRect){{textX, textY}, textSize};
    
    
    CGFloat originalH = CGRectGetMaxY(_originalTextViewFrame) + FLCellMargin;

    //配图
    NSUInteger count = _status.pic_urls.count;
    if (count) {
        CGFloat photoX = FLCellMargin;
        CGFloat photoY = CGRectGetMaxY(_originalTextViewFrame) + FLCellMargin;
        CGSize photoSize = [self photoSizeWithPhotoCount:count];
        _originalPhotoViewFrame = (CGRect){{photoX,photoY},photoSize};
        
        originalH = CGRectGetMaxY(_originalPhotoViewFrame) + FLCellMargin;
        
    }
   

    //原创微博的frame
    CGFloat originalX = 0;
    CGFloat originalY = 5;
    CGFloat originalW = FLAppScreenWidth;
    _originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
}

- (CGSize)photoSizeWithPhotoCount:(NSUInteger)count
{
    NSUInteger column = count == 4? 2 : 3;
    NSUInteger row = (count - 1) / column + 1;
    
    CGFloat photoWH = (FLAppScreenWidth - FLCellMargin * 3) / 3.0;
    CGFloat w = column * photoWH + (column - 1) * FLCellMargin / 2.0;
    CGFloat h = row * photoWH + (row - 1) * FLCellMargin / 2.0;
    
    return (CGSize){w,h};
}

#pragma mark- 计算转发微博Frame
- (void)setUpRetweetViewFrame
{
    
    //昵称
    CGFloat nameX = FLCellMargin;
    CGFloat nameY = nameX;
    CGSize size = [_status.retweetedName sizeWithFont:FLCellNameFont];
    _retweetNameViewFrame = (CGRect){{nameX,nameY},size};
    
    //正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameViewFrame) + FLCellMargin;
    CGFloat textW = FLAppScreenWidth - FLCellMargin * 2;
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:FLCellTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextViewFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextViewFrame) + FLCellMargin;
    //配图
    NSUInteger count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photoX = FLCellMargin;
        CGFloat photoY = CGRectGetMaxY(_retweetTextViewFrame) + FLCellMargin;
        CGSize photoSize = [self photoSizeWithPhotoCount:count];
        _retweetPhotoViewFrame = (CGRect){{photoX,photoY},photoSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotoViewFrame) + FLCellMargin;
        
    }

    
    
    
    //转发微博frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = FLAppScreenWidth;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
    
    
}





@end
