//
//  FLNavigationController.m
//  MyWeibo
//
//  Created by Mac on 16/2/2.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLNavigationController.h"
#import "UIBarButtonItem+Item.h"

@interface FLNavigationController ()<UINavigationControllerDelegate>

@property (strong,nonatomic) id popDelegate;

@end

@implementation FLNavigationController

+ (void)initialize
{
    //获取当前类的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    //将UIBarButtonItem前景色设置为 orangeColor
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateNormal];

    
    // 注意导航条上按钮不可能，用模型的文字属性设置是不好使
    // 设置没有用
   // [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //保存侧滑返回手势的代理
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    //清空侧滑返回手势的代理
     //self.interactivePopGestureRecognizer.delegate = nil;
    self.delegate = self;
    
}

//对非根控制器的导航栏按钮进行样式设置
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    FLLog(@"%ld",self.viewControllers.count);
    if (self.viewControllers.count != 0) {//非根控制器
        
        //设置左边和右边
        //左边
        //导航栏上的返回按钮被覆盖了 ，则滑动返回功能将失效 ，
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        
        //右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
        
      }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backToPre
{
    [self popViewControllerAnimated:YES];
}

- (void)backToRoot
{
    [self popToRootViewControllerAnimated:YES];
}



- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UITabBarController *tabBarVC = (UITabBarController *)keyWindow.rootViewController;
    
    //移除系统的tabBarButton
    for (UIView *view in tabBarVC.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }

}

 //导航栏上的返回按钮被覆盖了 ，则滑动返回功能将失效 ，
//重写navigationcontroler的代理方法
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    FLLog(@"%@",self.viewControllers[0]);
    if (viewController == self.viewControllers[0]) {//为根控制器时
        //还原侧滑返回手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }else{
        //清空侧滑返回手势的代理
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }
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
