//
//  FLRetweetView.m
//  MyWeibo
//
//  Created by asddfg on 16/3/10.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLRetweetView.h"
#import "FLStatusFrame.h"
#import "FLStatus.h"
#import "FLUser.h"
#import "FLPhotosView.h"

@interface FLRetweetView ()

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameView;
/**
 * 内容
 */
@property (nonatomic, weak) UILabel *textView;

/**
 *  配图
 */
@property (nonatomic, weak) FLPhotosView *photoView;

@end


@implementation FLRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imagewithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

//添加子控件
- (void)setUpAllChildView
{

    UILabel *text = [[UILabel alloc]init];
    text.font = FLCellTextFont;
    text.numberOfLines = 0;
    [self addSubview:text];
    _textView = text;
    
    UILabel *name = [[UILabel alloc]init];
    name.font = FLCellNameFont;
    [self addSubview:name];
    _nameView = name;
    
    //配图
    FLPhotosView *photoView = [[FLPhotosView alloc] init];
    [self addSubview:photoView];
    _photoView = photoView;
    
}

- (void)setStatusF:(FLStatusFrame *)statusF
{
    _statusF = statusF;
    FLStatus *status = statusF.status;
    
    _nameView.frame = statusF.retweetNameViewFrame;
    _nameView.text = status.retweetedName;
    
    _textView.text = status.retweeted_status.text;
    _textView.frame = statusF.retweetTextViewFrame;
    
    _photoView.frame = statusF.retweetPhotoViewFrame;
    _photoView.pic_urls = status.retweeted_status.pic_urls;
    
}

@end
