//
//  FLComposeToolBar.h
//  MyWeibo
//
//  Created by asddfg on 16/3/14.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLComposeToolBar;
@protocol FLComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(FLComposeToolBar *)toolBar didClickBtnAtIndex:(NSUInteger)index;

@end


@interface FLComposeToolBar : UIView

@property (nonatomic, weak) id<FLComposeToolBarDelegate> delegate;

@end
