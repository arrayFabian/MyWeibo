//
//  FLTabBarButton.m
//  MyWeibo
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLTabBarButton.h"
#import "FLBadgeView.h"


#define FLImageRidio 0.7

@interface FLTabBarButton ()

@property (nonatomic,weak) FLBadgeView *badgeView;

@end

@implementation FLTabBarButton

- (void)setHighlighted:(BOOL)highlighted{ }


- (FLBadgeView *)badgeView
{
    if (_badgeView == nil) {
        FLBadgeView *btn = [FLBadgeView buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:btn];
        
        _badgeView = btn;
        
    }
    return _badgeView;
}
    
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        //字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        //图片和文字居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

//传递UITabBarItem给tabBarButton,重写item的set方法
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    //KVO
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
}

//只要监听的属性一有新值，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:_item.title forState:UIControlStateNormal];
    
    [self setImage:_item.image forState:UIControlStateNormal];
    
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    self.badgeView.badgeValue = _item.badgeValue;
    
    
}

//修改按钮内部子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * FLImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 5;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //3.badgeView
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
