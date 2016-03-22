//
//  FLStatusToolBar.m
//  MyWeibo
//
//  Created by asddfg on 16/3/10.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLStatusToolBar.h"
#import "FLStatus.h"


@interface FLStatusToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;

@property(nonatomic,strong) NSMutableArray * lines;

@property (nonatomic, weak) UIButton *retweet;

@property (nonatomic, weak) UIButton *comment;

@property (nonatomic, weak) UIButton *unlike;

@end

@implementation FLStatusToolBar


- (NSMutableArray *)lines
{
    if (_lines == nil) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setUpAllChildView];
        
        
    }
    return self;
}

//添加子控件
- (void)setUpAllChildView
{
    
    //转发
    _retweet = [self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"] backgroundImage:[UIImage imagewithStretchableName:@"timeline_card_bottom_background"] highlightBackgroundImage:[UIImage imagewithStretchableName:@"timeline_card_bottom_background_highlighted"]];
    
    //评论
    _comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"] backgroundImage:[UIImage imagewithStretchableName:@"timeline_card_bottom_background"] highlightBackgroundImage:[UIImage imagewithStretchableName:@"timeline_card_bottom_background_highlighted"]];

    
    //赞
    
    _unlike = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"] backgroundImage:[UIImage imagewithStretchableName:@"timeline_card_bottom_background"] highlightBackgroundImage:[UIImage imagewithStretchableName:@"timeline_card_bottom_background_highlighted"]];
    
    
    for (int i = 0; i < 2; i++) {
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [_lines  addObject:line];
        [self addSubview:line];
    }
    
    
}


- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage highlightBackgroundImage:(UIImage *)highlightBackgroundImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightBackgroundImage forState:UIControlStateHighlighted];
    
    [self.btns addObject:btn];
    [self addSubview:btn];
    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.btns.count;
    CGFloat x;
    CGFloat y = 0;
    CGFloat h = self.height;
    CGFloat w = self.width / count;
    
    for (int i =0 ; i < count; i++) {
        x = i * w;
        UIButton *btn = _btns[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    
    for (int i = 0; i < 2; i++) {
        UIImageView *line = _lines[i];
        UIButton *btn = _btns[i+1];
        line.center = CGPointMake(btn.x, self.height/2.0);
       
    }
    
    
}

- (void)setStatus:(FLStatus *)status
{
    _status = status;
    
    [self setBtn:_retweet title:status.reposts_count];
    [self setBtn:_comment title:status.comments_count];
    [self setBtn:_unlike title:status.attitudes_count];
    
    
}

- (void)setBtn:(UIButton *)btn title:(int)count
{
    NSString *title = nil;
    if (count) {
       
        if (count > 10000) {
            title = [NSString stringWithFormat:@"%d万",count / 10000];
        }else{
            title = [NSString stringWithFormat:@"%d",count];
        }
        [btn setTitle:title forState:UIControlStateNormal];
        
    }
}


@end
