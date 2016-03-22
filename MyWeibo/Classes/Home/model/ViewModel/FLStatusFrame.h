//
//  FLStatusFrame.h
//  MyWeibo
//
//  Created by asddfg on 16/3/10.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLStatus;
@interface FLStatusFrame : NSObject

/**
 *  微博模型
 */
@property (nonatomic, strong) FLStatus *status;


/**
 *  原创微博frame
 */
@property (nonatomic, assign) CGRect originalViewFrame;

/**  ******原创微博子控件frame******  */
/**
 *  原创微博头像
 */
@property (nonatomic, assign) CGRect originalIconViewFrame;
/**
 *  原创微博VIP
 */
@property (nonatomic, assign) CGRect originalVipViewFrame;
/**
 *  原创微博发布时间
 */
@property (nonatomic, assign) CGRect originalTimeViewFrame;
/**
 *  原创微博昵称
 */
@property (nonatomic, assign) CGRect originalNameViewFrame;
/**
 *  原创微博内容
 */
@property (nonatomic, assign) CGRect originalTextViewFrame;
/**
 *  原创微博来源
 */
@property (nonatomic, assign) CGRect originalSourceViewFrame;
/**
 *  原创微博配图
 */
@property (nonatomic, assign) CGRect originalPhotoViewFrame;


/**
 *  转发微博frame
 */
@property (nonatomic, assign) CGRect retweetViewFrame;

/**  ******原创微博子控件frame******  */

/**
 *  转发微博昵称
 */
@property (nonatomic, assign) CGRect retweetNameViewFrame;
/**
 *  转发微博内容
 */
@property (nonatomic, assign) CGRect retweetTextViewFrame;
/**
 *  转发微博配图
 */
@property (nonatomic, assign) CGRect retweetPhotoViewFrame;


/**
 *  toolbar frame
 */
@property (nonatomic, assign) CGRect toolBarFrame;

/**
 *  cell 高度
 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
