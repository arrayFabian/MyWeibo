//
//  FLOneViewController.m
//  MyWeibo
//
//  Created by Mac on 16/2/4.
//  Copyright © 2016年 fabian. All rights reserved.
//

#import "FLOneViewController.h"
#import "UIBarButtonItem+Item.h"


@interface FLOneViewController ()



@end

@implementation FLOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;

}




@end
