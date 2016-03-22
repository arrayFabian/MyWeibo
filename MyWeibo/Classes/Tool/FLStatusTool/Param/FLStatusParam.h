//
//  FLStatusParam.h
//  MyWeibo
//
//  Created by asddfg on 16/2/28.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLStatusParam : NSObject


/**
*  access_token
*/
@property (nonatomic, copy) NSString *access_token;
/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博）
 */
@property (nonatomic, copy) NSString *since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博
 */
@property (nonatomic, copy) NSString *max_id;

@end
