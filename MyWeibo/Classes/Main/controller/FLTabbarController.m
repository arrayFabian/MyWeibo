//
//  FLTabbarController.m
//  MyWeibo
//
//  Created by Mac on 16/2/1.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLTabbarController.h"

#import "FLTabBar.h"
#import "FLNavigationController.h"

#import "FLHomeViewController.h"
#import "FLMessageViewController.h"
#import "FLDiscoverViewController.h"
#import "FLProfileViewController.h"

#import "FLUserTool.h"
#import "FLUserResult.h"

#import "FLComposeViewController.h"

@interface FLTabbarController ()<FLTabBarDelegate>

@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic,weak) FLHomeViewController *home;

@property (nonatomic,weak) FLMessageViewController *message;

@property (nonatomic,weak) FLProfileViewController *profile;

@end

@implementation FLTabbarController

+ (void)initialize
{
    //设置item字体的颜色
    //获取当前类下的所有tabbarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attriDic = [NSMutableDictionary dictionary];
    //KVC
    attriDic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:attriDic forState:UIControlStateSelected];
    
}

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpAllChildViewControllers];
    
   // NSLog(@"%@",self.tabBar);
    FLLog(@"%@",self.tabBar);
    
    //自定义tabBar
    
    [self setUpTabBar];
    FLLog(@"%@",self.tabBar);
    
    //每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
    
    
}

- (void)requestUnread
{
    //请求微博的未读数
    [FLUserTool unreadWithSuccess:^(FLUserResult *result) {
        //首页未读提醒
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        //消息未读提醒
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",[result messageCount]];
        //我未读提醒
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        //应用图标提醒
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
        
        
    } failure:^(NSError *error) {
        
        
    }];

}


#pragma mark- 设置tabBar
- (void)setUpTabBar
{
    
    //自定义tabBar添加到系统的tabBar上时 注意frame

    FLTabBar *tabBar = [[FLTabBar alloc]initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    //设置代理
    tabBar.delegate = self;
    
    //给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    //添加自定义tabBar ,添加到系统的tabBar上
    [self.tabBar addSubview:tabBar];
    
    //移除系统的tabBar
    //[self.tabBar removeFromSuperview];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     //NSLog(@"%@",self.tabBar.subviews);
    FLLog(@"%@",self.tabBar.subviews);
    
    //移除系统的tabBarButton
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
    
    
}

#pragma mark- 添加所有的子控制器
- (void)setUpAllChildViewControllers
{
    //首页
    FLHomeViewController *home = [[FLHomeViewController alloc]init];
   
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
    
    //消息
    FLMessageViewController *message = [[FLMessageViewController alloc]init];
   
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;
    
    //发现
    FLDiscoverViewController *discover = [[FLDiscoverViewController alloc]init];
    
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    //我
    FLProfileViewController *me = [[FLProfileViewController alloc]init];
    
    [self setUpOneChildViewController:me image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    _profile = me;
}

#pragma mark- 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    //设置tabBarItem的模型属性
    //vc.tabBarItem.title = title;
    
    //设置navigationItem模型
    //vc.navigationItem.title = title;
    
    vc.title = title;
    
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    //保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    FLNavigationController *navi = [[FLNavigationController alloc]initWithRootViewController:vc];
    
    
    [self addChildViewController:navi];
    
    
}

#pragma mark- 当点击tabBar上的按钮时的代理方法
- (void)tabBar:(FLTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (self.selectedIndex == index) {
        switch (index) {
            case 0:
                //点击首页 刷新
                [_home refresh];
                break;
                
                
            default:
                break;
        }
    }
    
    self.selectedIndex = index;
}

//点击发布微博按钮
- (void)tabBarPlusButtonDidClick:(FLTabBar *)tabBar
{
    
    FLComposeViewController *compose = [[FLComposeViewController alloc]init];
    FLNavigationController *navi = [[FLNavigationController alloc]initWithRootViewController:compose];
    [self presentViewController:navi animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
