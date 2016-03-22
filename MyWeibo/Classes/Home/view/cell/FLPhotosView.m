//
//  FLPhotosView.m
//  MyWeibo
//
//  Created by asddfg on 16/3/12.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLPhotosView.h"
#import "FLPhotoView.h"
#import "FLPhoto.h"

#import <MJPhotoBrowser/MJPhotoBrowser.h>

@interface FLPhotosView ()



@end

@implementation FLPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //加9个imageView
        [self setUpAllChildImageView];
        
    }
    return self;
}

- (void)setUpAllChildImageView
{
    for (int i = 0; i < 9; i++) {
        FLPhotoView *imageView = [[FLPhotoView alloc]init];
        
        imageView.tag = i+10;
        [self addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        
    }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = (UIImageView *)tap.view;
    
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (FLPhoto *photo in _pic_urls) {
        MJPhoto *p = [[MJPhoto alloc]init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
      //  NSLog(@"%@",urlStr);
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        i++;
        p.srcImageView = tapView;
        [arrM addObject:p];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    browser.photos = arrM;
    browser.currentPhotoIndex = tapView.tag - 10;
    
    [browser show];
    
    
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    int count = self.subviews.count;
  //遍历9个子控件
    for (int i = 0; i < count; i++) {
        
        FLPhotoView *imageView = self.subviews[i];
        
        if (i < _pic_urls.count) {//显示
            imageView.hidden = NO;
            
            FLPhoto *photo = _pic_urls[i];
            //赋值
            imageView.photo = photo;
            
        }else{//隐藏
            imageView.hidden = YES;
            
        }
        
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat WH = (FLAppScreenWidth - FLCellMargin * 3) / 3.0;
    int column = 0;
    int row = 0;
    CGFloat margin = FLCellMargin/2.0;
    int columns = _pic_urls.count == 4?2:3;
    
    for (int i = 0; i < _pic_urls.count; i++) {
        UIImageView *imageView = self.subviews[i];
        column = i % columns;
        row = i / columns;
        x = column * WH + column * margin;
        y = row * WH + row * margin;
        imageView.frame = CGRectMake(x, y, WH, WH);
    }
    
    
}

@end
