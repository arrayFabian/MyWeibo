//
//  FLComposePhotosView.m
//  MyWeibo
//
//  Created by asddfg on 16/3/15.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLComposePhotosView.h"

@implementation FLComposePhotosView


- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = image;
    [self addSubview:imgView];
    
    
}

// 每添加一个子控件的时候也会调用，特殊如果在viewDidLoad添加子控件，就不会调用layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat margin = 10;
    CGFloat wh = (self.width - ((cols-1)+2)*margin)/cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    NSLog(@"%lu",(unsigned long)self.subviews.count);
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imgV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = margin + col * (wh + margin);
        y = margin + row * (wh + margin);
        imgV.frame = CGRectMake(x, y, wh, wh);
        NSLog(@"%f %f",x,y);
    }
    
    
}


@end
