//
//  FLSearchBar.m
//  MyWeibo
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLSearchBar.h"

@implementation FLSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
        
        self.background = [UIImage imagewithStretchableName:@"searchbar_textfield_background"];
        
        //设置左边的view
        //initWithFrame： 默认UIimageview的尺寸跟图片一样
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imgView.width += 10;
        imgView.contentMode = UIViewContentModeCenter;
        self.leftView = imgView;
        
        //一定要设置，想要显示搜索框左边的试图，一定要设置左边试图的模式
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
