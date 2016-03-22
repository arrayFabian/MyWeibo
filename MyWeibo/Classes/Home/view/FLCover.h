//
//  FLCover.h
//  MyWeibo
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLCover;
@protocol FLCoverDelegate <NSObject>

@optional
//点击蒙版时调用
- (void)coverDidClickCover:(FLCover *)cover;

@end

@interface FLCover : UIView
/**
 *  显示蒙板
 */
+ (instancetype)show;

//设置浅灰色蒙板
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id<FLCoverDelegate> delegate;

@end
