//
//  FLNewFeatureCell.h
//  MyWeibo
//
//  Created by Mac on 16/2/25.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;


//判断是否最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;

@end
