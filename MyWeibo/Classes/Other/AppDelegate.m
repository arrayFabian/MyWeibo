//
//  AppDelegate.m
//  MyWeibo
//
//  Created by Mac on 16/1/31.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "AppDelegate.h"
#import "FLRootTool.h"
#import "FLAccountTool.h"
#import "FLOAuthViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册通知
    
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
    [application registerUserNotificationSettings:setting];
    
    
    //真机上后台播放，要设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    //设置会话类型
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //激活
    [session setActive:YES error:nil];
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    //判断是否授权
    if ([FLAccountTool account]) {//已经授权
        
        [FLRootTool chooseRootViewController:self.window];
        
    }else{
        FLOAuthViewController *oauthVC = [[FLOAuthViewController alloc] init];
        
        self.window.rootViewController = oauthVC;
    }
   
    [self.window makeKeyAndVisible];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
   
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    
    //无限播放
    player.numberOfLoops = -                                                                                                                                                                                                            1;
    [player play];
    
    _player = player;
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   //开启后台任务
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        [application endBackgroundTask:ID];
        
    }];


}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
