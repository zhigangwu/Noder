//
//  RecentTopicsViewController.m
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "RecentTopicsViewController.h"
#import "RecentTopicsCell.h"
#import "Loginapi.h"
#import "DetailViewController.h"
#import "UIColor+TitleColor.h"
#import "UIFont+SetFont.h"
#import "UIColor+TitleColor.h"
#import <UIScrollView+EmptyDataSet.h>

@interface RecentTopicsViewController () <DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation RecentTopicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"最近发布";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;

    //不显示空白cell
    UIView *footview = [[UIView alloc] init];
    footview.backgroundColor = [UIColor backgroundcolor];
    self.tableView.tableFooterView = footview;
    
    //去掉返回按钮中的back
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
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
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1/1.0]];
    
    Loginapi *recentTopics = [[Loginapi alloc] init];
    recentTopics.loginname = self.TopicsLoginname;
    [recentTopics startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        
        self.loginModel = request.responseJSONObject;
        self.array = self.loginModel.recent_topics;
        
        [self.tableView reloadData];        
    } failure:NULL];
    
    [self.tableView registerClass:[RecentTopicsCell class] forCellReuseIdentifier:@"RecentTopicsCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecentTopicsCell *recenttopicsCell = [tableView dequeueReusableCellWithIdentifier:@"RecentTopicsCell"
                                                                       forIndexPath:indexPath];
    if (!recenttopicsCell) {
        recenttopicsCell = [[RecentTopicsCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                 reuseIdentifier:@"RecentTopicsCell"];
    }
    
    self.recent_topics = [self.array objectAtIndex:indexPath.row];
    [recenttopicsCell configWithItem:self.recent_topics];
    
    //    分割线全屏
    if ([recenttopicsCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [recenttopicsCell setLayoutMargins:UIEdgeInsetsZero];
    }

    
    return recenttopicsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    self.recent_topics = [self.array objectAtIndex:indexPath.row];
    detail.detailId = self.recent_topics.id;
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
