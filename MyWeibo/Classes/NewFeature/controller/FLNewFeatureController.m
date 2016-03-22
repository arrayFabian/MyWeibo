//
//  FLNewFeatureController.m
//  MyWeibo
//
//  Created by Mac on 16/2/25.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLNewFeatureController.h"
#import "FLNewFeatureCell.h"


@interface FLNewFeatureController ()

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation FLNewFeatureController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //self.view.backgroundColor = [UIColor redColor];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[FLNewFeatureCell class] forCellWithReuseIdentifier:ID];
   
    // Do any additional setup after loading the view.
    
    [self setUpPageControl];
    
}

- (void)setUpPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    //center
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height - 20);
    _pageControl = pageControl;
    [self.view addSubview:pageControl];
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    return [super initWithCollectionViewLayout:layout];
}

#pragma mark collectionview data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FLNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath ];
   
    //拼接图片名称 3.5 320 480
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
      NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row+1];
    if (screenH > 480) {// 5 5s 6 6p
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
    }
    
    cell.image = [UIImage imageNamed:imageName];
    
   // cell.backgroundColor = [UIColor redColor];
    
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}

#pragma mark- uiscrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取偏移量，计算当前第几页
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    //设置页数
    _pageControl.currentPage = page;
}

@end
