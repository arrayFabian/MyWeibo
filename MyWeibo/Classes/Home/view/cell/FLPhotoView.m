//
//  FLPhotoView.m
//  MyWeibo
//
//  Created by Mac on 16/3/12.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLPhotoView.h"
#import "FLPhoto.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FLPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation FLPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        UIImageView *gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
        
    }
    return self;
}

- (void)setPhoto:(FLPhoto *)photo
{
    _photo = photo;
    
    NSString *urlString = photo.thumbnail_pic.absoluteString;
   // NSLog(@"%@",urlString);
    urlString = [urlString stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    //判断gif是否隐藏
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
    
    
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //用点语法
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
    
    
}




@end
