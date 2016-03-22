//
//  FLTitleButton.m
//  MyWeibo
//
//  Created by Mac on 16/2/4.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLTitleButton.h"

@implementation FLTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imagewithStretchableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.currentImage == nil) {
        return;
    }
    
    //title
    self.titleLabel.x = self.imageView.x;
    //image
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);

    
}

//重写setTitle方法，拓展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}


- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self sizeToFit];
}



@end
