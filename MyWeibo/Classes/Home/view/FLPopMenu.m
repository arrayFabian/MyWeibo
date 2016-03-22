//
//  FLPopMenu.m
//  MyWeibo
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLPopMenu.h"

@implementation FLPopMenu

//显示弹出菜单
+ (instancetype)showInRect:(CGRect)rect
{
    FLPopMenu *menu = [[FLPopMenu alloc]initWithFrame:rect];
    
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imagewithStretchableName:@"popover_background"];
    
    //添加到猪窗口上
    [FLKeyWindow addSubview:menu];
    
    return menu;
}

//隐藏菜单
+ (void)hide
{
    for (UIView *popMenu in FLKeyWindow.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
 
}

//设置内容试图
- (void)setContentView:(UIView *)contentView
{
    //先移除之前的内容试图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //计算内容试图的尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}

@end
