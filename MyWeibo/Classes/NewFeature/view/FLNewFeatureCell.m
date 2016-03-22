//
//  FLNewFeatureCell.m
//  MyWeibo
//
//  Created by Mac on 16/2/25.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLNewFeatureCell.h"
#import "FLTabbarController.h"

@interface FLNewFeatureCell()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *shareButton;

@property (nonatomic, weak) UIButton *startButton;

@end


@implementation FLNewFeatureCell

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton = btn;
        [self.contentView addSubview:btn];
        
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        
        // 让button高亮时不变成阴影
        btn.adjustsImageWhenHighlighted = NO;
    }
    return _shareButton;
}



- (void)share
{
    _shareButton.selected = !_shareButton.isSelected;
}

- (UIButton *)startButton
{
    if (_startButton == nil) {
       
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton = startBtn ;
        [self.contentView addSubview:startBtn ];
        
        [startBtn  setTitle:@"开始微博" forState:UIControlStateNormal];
       // [startBtn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn  setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        
        [startBtn  sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return _startButton;
}

- (void)start
{
    FLTabbarController *tabBarVC = [[FLTabbarController alloc]init];
    FLKeyWindow.rootViewController = tabBarVC;
}


- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageview = [[UIImageView alloc] init];
        _imageView = imageview;
        
        [self.contentView addSubview:imageview];
    }
    return _imageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //布局
    self.imageView.frame = self.bounds;
    
    //分享按钮
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    //开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

//判断是否最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count
{
    if (indexPath.row == count - 1) {//最后一页，显示分享和开始按钮
        self.startButton.hidden = NO;
        self.shareButton.hidden = NO;
    }else{//非最后一页，隐藏分享和开始按钮
        self.startButton.hidden = YES;
        self.shareButton.hidden = YES;
    }
}

















@end
