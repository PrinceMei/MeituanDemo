//
//  GroupPurchaseViewController.m
//  Meituan
//
//  Created by 臧其龙 on 15/9/15.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

#import "GroupPurchaseViewController.h"
#import "UIColor+HexColor.h"
#import "Seller+request.h"
#import "SellerTableViewCell.h"
#import "LineView.h"
#import <AFNetworking.h>

static NSString * const kSellerTableViewCellID = @"kSellerTableViewCellID";

@interface GroupPurchaseViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *sellerArray;
    AFHTTPRequestOperation *operation;
}

@end

@implementation GroupPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHex:@"#06C1AE"]];
    
    UITabBarItem *item = self.tabBarController.tabBar.items[0];
    [item setSelectedImage:[UIImage imageNamed:@"icon_tabbar_homepage_selected"]];
    
    self.shouldInitPullToRefresh = YES;
//    [Seller requestSellerWithCompletion:^(id object) {
//        sellerArray = (NSArray *)object;
//        [self.tableView reloadData];
//    }];
    //        if (operation) {
    //            [operation cancel];
    //        }
    for (int i = 1; i <= 10; i++) {

        if (operation) {
            [operation cancel];
        }
      operation = [Seller requestSellerWithCompletion:^(id object) {
            NSLog(@"finished download %d",i);
            
        }];
        
    }
    
    
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource && Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sellerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SellerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSellerTableViewCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Seller *seller = sellerArray[indexPath.row];
    
    [cell bindDataWithSeller:seller];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LineView *headerView = [[LineView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 30)];
    [headerView addLineWithLineType:LineViewTypeTop];
    UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, 35)];
    likeLabel.text = @"猜你喜欢";
    likeLabel.textColor = [UIColor blackColor];
    likeLabel.font = [UIFont boldSystemFontOfSize:14];
    [headerView addSubview:likeLabel];
    return headerView;
}
@end
