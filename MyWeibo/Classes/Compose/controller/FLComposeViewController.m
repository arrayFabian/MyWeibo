//
//  FLComposeViewController.m
//  MyWeibo
//
//  Created by Mac on 16/3/12.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLComposeViewController.h"
#import "FLTextView.h"
#import "FLComposeToolBar.h"
#import "FLComposePhotosView.h"
#import "FLComposeTool.h"
#import "MBProgressHUD+MJ.h"

#import "FLComposeParam.h"



@interface FLComposeViewController ()<UITextViewDelegate,FLComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) FLTextView *textView;

@property (nonatomic, weak) FLComposeToolBar *toolBar;

@property (nonatomic, weak) FLComposePhotosView *photosView;

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation FLComposeViewController

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNavigation];
    
    [self setUpTextView];
    
    [self setUpToolBar];
    
    //监听键盘的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setUpPhotosView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [_textView becomeFirstResponder];
}

- (void)setUpPhotosView
{
    FLComposePhotosView *photosView = [[FLComposePhotosView alloc]initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height-70)];
    [_textView addSubview:photosView];
    _photosView = photosView;
  
    
}

- (void)keyBoardWillChangeFrame:(NSNotification *)noti
{
    //NSLog(@"%@",noti);
    
    CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    CGRect frame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    if (frame.origin.y == self.view.height) {//没弹出键盘
        [UIView animateWithDuration:duration animations:^{
            
            _toolBar.transform = CGAffineTransformIdentity;
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
    
    
    
    
    
    
}




- (void)setUpToolBar
{
    FLComposeToolBar *toolBar = [[FLComposeToolBar alloc]initWithFrame:CGRectMake(0, self.view.height - 35, self.view.width, 35)];
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    
    _toolBar.delegate = self;
    
}

- (void)setUpTextView
{
    FLTextView *textView = [[FLTextView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:textView];
    _textView = textView;
    
    textView.font = [UIFont systemFontOfSize:18];
    textView.placeholder = @"请输入发送内容";
    
    
    
    //允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    _textView.delegate = self;
    
    //监听文本框的输入
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark- 监听通知调用的方法
- (void)textChange:(NSNotification *)notice
{
    //判断textview有没有内容
    if (_textView.text.length) {
        _textView.hideplaceholder = YES;
        _rightItem.enabled = YES;
    }else{
        _textView.hideplaceholder = NO;
        _rightItem.enabled = NO;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)setUpNavigation
{
    self.title = @"发微博";
    //left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    //right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
   UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
    barItem.enabled = NO;
    _rightItem = barItem;
    
                                             
}

- (void)dismiss
{
    [self.view endEditing:YES];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)compose
{
    // 新浪上传：文字不能为空，分享图片
    // 二进制数据不能拼接url的参数，只能使用formdata
    // 判断下有没有图片
    FLLog(@"%s",__func__);
    if (self.images.count) {
        //发送图片
        [self sendPicture];
    }else{
        //发送文字
        [self sendTitle];
    }
    
    
    
}

- (void)sendPicture
{
    NSString *status = _textView.text.length?_textView.text :@"分享图片";
    
    UIImage *image = self.images[0];

    _rightItem.enabled = NO;
    
    [FLComposeTool composeWithStatus:status picture:image success:^{
        [MBProgressHUD showSuccess:@"发送图片成功"];
        _rightItem.enabled = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送图片失败"];
        _rightItem.enabled = YES;
        
    }];
    
       
    
    
    
}

- (void)sendTitle
{
    [FLComposeTool composeWithStatus:self.textView.text success:^{
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
        [self.textView resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        FLLog(@"error");
        
    }];
}

#pragma mark- toolbar delegate
- (void)composeToolBar:(FLComposeToolBar *)toolBar didClickBtnAtIndex:(NSUInteger)index
{
    if (index == 0) {//点击相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    
    }
}

#pragma mark- imagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    FLLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.images addObject:image];
    _photosView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _rightItem.enabled = YES;
    
    
    
}

@end
