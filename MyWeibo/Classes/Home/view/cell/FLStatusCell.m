//
//  FLStatusCell.m
//  MyWeibo
//
//  Created by asddfg on 16/3/10.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLStatusCell.h"
#import "FLOriginalView.h"
#import "FLRetweetView.h"
#import "FLStatusToolBar.h"
#import "FLStatusFrame.h"
#import "FLStatus.h"

@interface FLStatusCell ()

@property (nonatomic, weak)  FLOriginalView *originalView;
@property (nonatomic, weak)  FLRetweetView *retweetView;
@property (nonatomic, weak)  FLStatusToolBar *toolBarView;

@end

@implementation FLStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        [self setUpAllChildView];
       self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

 //添加子控件
- (void)setUpAllChildView
{
    //原创
    FLOriginalView *originalView = [[FLOriginalView alloc]init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    //转发
    FLRetweetView *retweetView = [[FLRetweetView alloc]init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    //工具条
    FLStatusToolBar *toolBar = [[FLStatusToolBar alloc]init];
    [self addSubview:toolBar];
    _toolBarView = toolBar;
}

+ (instancetype)statuscellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setStatusF:(FLStatusFrame *)statusF
{
    _statusF = statusF;
    
    
    
   //用视图模型传
    
    _originalView.statusF = statusF;
    _originalView.frame = statusF.originalViewFrame;
    
    if (statusF.status.retweeted_status) {
        _retweetView.statusF = statusF;
        _retweetView.frame = statusF.retweetViewFrame;
        _retweetView.hidden = NO;

    }else{
        _retweetView.hidden = YES;
    }
    
    
    _toolBarView.status = statusF.status;
    _toolBarView.frame = statusF.toolBarFrame;
    
}

@end
