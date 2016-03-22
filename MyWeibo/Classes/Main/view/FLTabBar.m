//
//  FLTabBar.m
//  MyWeibo
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLTabBar.h"
#import "FLTabBarButton.h"

@interface FLTabBar ()

@property(nonatomic,weak) UIButton *plusButton;

@property(nonatomic,strong) NSMutableArray *buttons;

@property(nonatomic,weak) UIButton *selectedButton;

@end

@implementation FLTabBar

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    //遍历模型数组，创建对应的tabBarButton
    for (UITabBarItem *item in _items) {
        FLTabBarButton *btn = [FLTabBarButton buttonWithType:UIButtonTypeCustom];
        
        //给btn的模型赋值，让按钮的内容有模型决定
        btn.item = item;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (btn.tag == 0) {  //选中第0个
            [self btnClick:btn];
        }
        
        [self addSubview:btn];
        
        [self.buttons addObject:btn];
    }
    
}

//点击tabBarButton时调用
- (void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    //通知tabBarVc切换控制器 (代理方法)
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [self.delegate tabBar:self didClickButton:button.tag];
    }
}

- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [btn sizeToFit];
        _plusButton = btn;
        [self addSubview:_plusButton];
        
        //btn添加点击事件
        [btn addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _plusButton;
}

- (void)plusButtonClick
{
    //代理
    if ([self.delegate respondsToSelector:@selector(tabBarPlusButtonDidClick:)]) {
        [self.delegate tabBarPlusButtonDidClick:self];
    }
    
}

//调整子控制器的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = h;
    
    int i = 0;
    //tabBarButton的frame
    for (UIView *tabBarButton in self.buttons) {
        
            if (i == 2) {
                i = 3;
            }
            
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        
    }
    //设置添加按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
}


@end
