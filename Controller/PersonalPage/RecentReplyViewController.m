
//
//  RecentReplyViewController.m
//  Noder
//
//  Created by alienware on 2017/5/22.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "RecentReplyViewController.h"
#import "RecentReplyCell.h"
#import "Masonry.h"
#import "Loginapi.h"
#import "DetailViewController.h"
#import "UIColor+TitleColor.h"
#import "UIFont+SetFont.h"
#import <UIScrollView+EmptyDataSet.h>

@interface RecentReplyViewController () <DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation RecentReplyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"最近回复";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
    //去掉返回按钮中的back
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
//    self.tableView.backgroundColor = [UIColor whiteColor]
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1/1.0]];
    
    //不显示空白cell
    UIView *footview = [[UIView alloc] init];
    footview.backgroundColor = [UIColor backgroundcolor];
    self.tableView.tableFooterView = footview;
    
    //    cell分割线全屏
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    Loginapi *recentAPI = [[Loginapi alloc] init];
    recentAPI.loginname = self.recenrLoginname;
    [recentAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        
        self.loginModel = request.responseJSONObject;
        self.array = self.loginModel.recent_replies;

        [self.tableView reloadData];
    } failure:NULL];
    
    [self.tableView registerClass:[RecentReplyCell class] forCellReuseIdentifier:@"RecentReplyCell"];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecentReplyCell *recentreplyCell = [tableView dequeueReusableCellWithIdentifier:@"RecentReplyCell"
                                                                     forIndexPath:indexPath];

     self.recent_replies = [self.array objectAtIndex:indexPath.row];
    
    [recentreplyCell configWithItem:self.recent_replies];
    
    //    分割线全屏
    if ([recentreplyCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [recentreplyCell setLayoutMargins:UIEdgeInsetsZero];
    }

    
    return recentreplyCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    self.recent_replies = [self.array objectAtIndex:indexPath.row];
    detail.detailId = self.recent_replies.id;
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无收藏";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:17],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1/1.0]
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}




@end
