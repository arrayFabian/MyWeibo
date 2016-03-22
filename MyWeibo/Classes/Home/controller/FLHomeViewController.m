//
//  FLHomeViewController.m
//  MyWeibo
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLHomeViewController.h"

#import "FLOneViewController.h"
#import "FLCover.h"
#import "FLPopMenu.h"

#import "FLTitleButton.h"
#import "UIBarButtonItem+Item.h"

#import "FLAccountTool.h"
#import "FLAccount.h"

#import "FLStatus.h"
#import "FLUser.h"
#import <MJExtension.h>

#import <AFNetworking.h>

#import <MJRefresh.h>

#import "FLHttpTool.h"
#import "FLStatusTool.h"
#import "FLUserTool.h"

#import "FLStatusCell.h"
#import "FLStatusFrame.h"

@interface FLHomeViewController ()<FLCoverDelegate>

@property (nonatomic, weak) FLTitleButton *titleButton;

@property (nonatomic, strong) FLOneViewController *one;

@property(nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation FLHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (FLOneViewController *)one
{
    if (_one == nil) {
        _one = [[FLOneViewController alloc]init];
    }
    return _one;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //设置导航条内容
    [self setUpNavigationBar];
    
    //下拉刷新 MJRefresh
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    
    //马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    //上拉刷新 MJRefresh
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    
    //一开始使用之前的微博名称，然后在发送用户信息请求，直接赋值
    //获取用户的信息 
    [FLUserTool userInfoWithSuccess:^(FLUser *user) {
       //请求到当前账号的用户信息
        //设置导航栏的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //获取当前的账号
        FLAccount *account = [FLAccountTool account];
        account.name = user.name;
        
        //保存用户的昵称
        [FLAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark- loadMoreStatus
- (void)loadMoreStatus
{
    NSString *max_idStr = nil;
    //max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    if (self.statusFrames.count) {
        long long max_id = [[[[self.statusFrames lastObject] status] idstr] longLongValue]- 1;
        
        max_idStr = [NSString stringWithFormat:@"%lld",max_id];
    }

   [FLStatusTool moreStatusWithMaxId:max_idStr success:^(NSArray *statuses) {
       //结束上拉刷新
       [self.tableView.mj_footer endRefreshing];
       
       //更早之前的微博添加到数组中
       //模型转 视图模型
       NSMutableArray *statusFrames = [NSMutableArray array];
       for (FLStatus *status in statuses) {
           FLStatusFrame *statusF = [[FLStatusFrame alloc]init];
           //set方法中 计算各子控件的frame并计算cell行高
           statusF.status = status;
           [statusFrames addObject:statusF];
       }

       //遍历数据的元素加到另一个数组中
       [self.statusFrames addObjectsFromArray:statusFrames];
       
       [self.tableView reloadData];
       
   } failure:^(NSError *error) {
       
   }];
    
}

#pragma mark- 刷新最新微博
- (void)refresh
{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark- loadNewStatus
- (void)loadNewStatus
{
    NSString *sinceIdStr = nil;
    
    if (self.statusFrames.count) {//有微博才要下拉刷新
       sinceIdStr = [[self.statusFrames[0] status] idstr];
    }
    
    [FLStatusTool newStatusWithSinceId:sinceIdStr success:^(NSArray *statuses) {
        
        //结束下拉刷新
        [self.tableView.mj_header endRefreshing];

        //新微博插入到数组中
        //模型转 视图模型
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (FLStatus *status in statuses) {
            FLStatusFrame *statusF = [[FLStatusFrame alloc]init];
            //set方法中 计算各子控件的frame并计算cell行高
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        /*
         for (NSDictionary *dict in dictArr) {
         FLStatus *status = [FLStatus mj_objectWithKeyValues:dict];
         if (status.pic_urls.count) {
         NSLog(@"%@",status.pic_urls);
         }
         [self.statuses addObject:status];
         }
         */
        FLLog(@"%@",self.statusFrames);
        
        [self.tableView reloadData];
        
        //提醒更新的微博数
        
        [self showNewStatusNum:statuses.count];
        
    } failure:^(NSError *error) {
        
    }];
    
       
}

#pragma mark- 提醒更新的微博数
- (void)showNewStatusNum:(NSInteger)count
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame) - 35, self.view.width, 35)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.text = [NSString stringWithFormat:@"新微博数量%ld",(long)count];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        //平移
        label.transform = CGAffineTransformMakeTranslation(0, 35);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity; //还原
        } completion:^(BOOL finished) {
             [label removeFromSuperview];//移除
            
        }];
    }];
    
    
    
    
}



#pragma mark- 设置导航条
- (void)setUpNavigationBar
{
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    //titleview
    FLTitleButton *titleButton = [FLTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    NSString *title = [FLAccountTool account].name?:@"首页";
    
    
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    //高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
}

//点击标题按钮
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.isSelected;
    
    //蒙板在下 菜单在上
    
    //弹出蒙板
    FLCover *cover = [FLCover show];
    cover.delegate = self;
    
    //弹出pop菜单
    CGFloat popW = 200;
    CGFloat popH = popW;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popY = 55;
    
    FLPopMenu *menu = [FLPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    //菜单的内容试图 为一个tableView
    menu.contentView = self.one.view;
    
}

//点击蒙板的时候调用  代理方法
- (void)coverDidClickCover:(FLCover *)cover
{
    //隐藏pop菜单
    [FLPopMenu hide];
    
    _titleButton.selected = NO;
}

- (void)friendsearch
{
    FLLog(@"%s",__func__);
    
}

- (void)pop
{
    FLLog(@"%s",__func__);
    
        
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLStatusCell *cell = [FLStatusCell statuscellWithTableView:tableView];
    FLStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    cell.statusF = statusF;
    
    return cell;
}


#pragma mark- tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLStatusFrame *statusF = self.statusFrames[indexPath.row];
   // NSLog(@"%f",statusF.cellHeight);
    return statusF.cellHeight;
    
}


@end
