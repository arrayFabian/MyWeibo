//
//  FLStatus.h
//  MyWeibo
//
//  Created by asddfg on 16/2/27.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

@class FLUser;
@interface FLStatus : NSObject<MJKeyValue>


/**
*  被转发的原微博信息字段
*/
@property(nonatomic,strong) FLStatus *retweeted_status;
/**
 *  被转发的原微博的昵称
 */
@property (nonatomic, copy) NSString *retweetedName;

/**
*  博作者的用户信息字段 详细
*/
@property(nonatomic,strong) FLUser * user;

/**
*  微博创建时间
*/
@property (nonatomic, copy) NSString *created_at;
/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  表态数(赞)
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  配图数组(FLPhoto)
 */
@property(nonatomic,strong) NSArray * pic_urls;

@end
