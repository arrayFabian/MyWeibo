//
//  FLOriginalView.m
//  MyWeibo
//
//  Created by asddfg on 16/3/10.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLOriginalView.h"
#import "FLStatusFrame.h"
#import "FLUser.h"
#import "FLStatus.h"
#import "FLPhotosView.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface FLOriginalView ()
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  VIP
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  发布时间
 */
@property (nonatomic, weak) UILabel *timeView;
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameView;
/**
 *  微博内容
 */
@property (nonatomic, weak) UILabel *textView;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceView;
/**
 *  配图
 */
@property (nonatomic, weak) FLPhotosView *photoView;

@end


@implementation FLOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imagewithStretchableName:@"timeline_card_top_background"];
    }
    return self;
}

 //添加子控件
- (void)setUpAllChildView
{
    
    UIImageView *iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    _iconView = iconView;
  
    
    
    
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    UILabel *time = [[UILabel alloc]init];
    time.font = FLCellTimeFont;
    time.textColor = [UIColor orangeColor];
    [self addSubview:time];
    _timeView = time;
    
    UILabel *text = [[UILabel alloc]init];
    [self addSubview:text];
    text.font = FLCellTextFont;
    text.numberOfLines = 0;
    _textView = text;

    UILabel *source = [[UILabel alloc]init];
    [self addSubview:source];
    source.font = FLCellSourceFont;
    source.textColor = [UIColor grayColor];
    _sourceView = source;

    UILabel *name = [[UILabel alloc]init];
    [self addSubview:name];
    name.font = FLCellNameFont;
    _nameView = name;

    //配图
    FLPhotosView *photoView = [[FLPhotosView alloc]init];
    [self addSubview:photoView];
    _photoView = photoView;
    
}



- (void)setStatusF:(FLStatusFrame *)statusF
{
    _statusF = statusF;
    
    [self setUpData];
    
    [self setUpFrame];
 
    
}

- (void)setUpData
{
    FLStatus *status = _statusF.status;
    
    //头像
    //利用SDWebImage
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    

    //正文
    _textView.text = status.text;
    
    //时间
    _timeView.text = status.created_at;
    
    //来源
    _sourceView.text = status.source;
    
    //昵称
    _nameView.text = status.user.name;
    if (status.user.vip) {
        _nameView.textColor = [UIColor orangeColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    
    //VIP
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    
    //配图
    _photoView.pic_urls = status.pic_urls;
    
    
}

- (void)setUpFrame
{
    _iconView.frame = _statusF.originalIconViewFrame;
    _iconView.layer.cornerRadius = self.iconView.bounds.size.width / 2.0;
    _iconView.layer.masksToBounds = YES;
    
    _nameView.frame = _statusF.originalNameViewFrame;
    
    _textView.frame = _statusF.originalTextViewFrame;
    
    
    
    //时间 因为时间显示的内容会变 每次重新计算
    FLStatus *status = _statusF.status;
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + FLCellMargin * 0.5;
    CGSize timesize = [status.created_at sizeWithFont:FLCellTimeFont];
    _timeView.frame = (CGRect){{timeX,timeY},timesize};
    
    //来源 依赖时间的frame
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + FLCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:FLCellSourceFont];
    _sourceView.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    
    if (_statusF.status.user.isVip) {
        _vipView.frame = _statusF.originalVipViewFrame;
        _vipView.hidden = NO;
    }else{
        _vipView.hidden = YES;
    }
    
    //配图
    _photoView.frame = _statusF.originalPhotoViewFrame;
    
}


@end
