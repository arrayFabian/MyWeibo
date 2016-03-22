//
//  FLOAuthViewController.m
//  MyWeibo
//
//  Created by asddfg on 16/2/26.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import <AFNetworking.h>
#import "FLRootTool.h"
#import "FLAccount.h"
#import "FLAccountTool.h"

#define AppKey @"976983563"
#define AppSecret @"8e39c9ca66ae57caa847f38630571e3c"



@interface FLOAuthViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) MBProgressHUD *mbProgress;

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation FLOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    //展示网页 -》 webview
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView = webView;
   
    [self.view addSubview:webView];
    
    //网页请求
    [self requestToken];
    
    
    webView.delegate = self;
}

//请求授权
- (void)requestToken
{
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    
    NSString *client_id = AppKey;
    
    NSString *redirect_uri =  @"http://www.baidu.com";
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];

    
}

/*
 client_id	true	string	申请应用时分配的AppKey。
 redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
 */

/*
 App Key：976983563
 App Secret：8e39c9ca66ae57caa847f38630571e3c
 */


#pragma mark- webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //提示用户开始加载
    [MBProgressHUD showMessage:@"正在加载..."];
}
//网页加载结束，隐藏进度提示
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
//网页加载失败，隐藏进度提示
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}


//拦截web请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   FLLog(@"%@",request.URL.absoluteString);
    
    NSString *urlString = request.URL.absoluteString;
    //获取code(requestToken)
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length) {//有code=
        NSString *code = [urlString substringFromIndex:range.location + range.length ];
       
        //access token请求
        FLLog(@"code:%@",code);
        
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}

/*
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */


//获取accessToken post请求
- (void)accessTokenWithCode:(NSString *)code
{
    [FLAccountTool accountWithCode:code success:^{
        //调到主页
        [FLRootTool chooseRootViewController:FLKeyWindow];
    } failure:^(NSError *error) {
        
    }];
}

@end
