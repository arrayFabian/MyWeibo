//
//  FLTabBar.h
//  MyWeibo
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLTabBar;

@protocol  FLTabBarDelegate <NSObject>

@optional

- (void)tabBar:(FLTabBar *)tabBar didClickButton:(NSInteger)index;


- (void)tabBarPlusButtonDidClick:(FLTabBar *)tabBar;


@end

@interface FLTabBar : UIView
/**
 *  保存每个按钮的tabBarItem模型
 */
@property (nonatomic,strong) NSArray *items;

@property (nonatomic,weak) id<FLTabBarDelegate> delegate;

@end
