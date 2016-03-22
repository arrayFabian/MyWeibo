//
//  FLStatusCell.h
//  MyWeibo
//
//  Created by asddfg on 16/3/10.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLStatusFrame;
@interface FLStatusCell : UITableViewCell

@property(nonatomic,strong) FLStatusFrame * statusF;

+ (instancetype)statuscellWithTableView:(UITableView *)tableView;

@end
