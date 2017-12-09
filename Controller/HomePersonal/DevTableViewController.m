//
//  DevTableViewController.m
//  Noder
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "DevTableViewController.h"
#import "DevAPI.h"
#import "DevTableViewCell.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "UIColor+tableBackground.h"
#import "DevDataModel.h"

@interface DevTableViewController ()

@end

@implementation DevTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    cell分割线全屏
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [UIColor tableBackground];
    
    DevAPI *devAPI = [[DevAPI alloc] init];
    [devAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        
        [self.tableView reloadData];
    } failure:NULL];
    
    [self.tableView registerClass:[DevTableViewCell class] forCellReuseIdentifier:@"DevTableViewCell"];
    
    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNoreData];
    }];
}

- (void)loadNewData
{
    DevAPI *devAPI = [[DevAPI alloc] init];
    [devAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:NULL];
}

- (void)loadNoreData
{
    DevAPI *devAPI = [[DevAPI alloc] init];
    [devAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:NULL];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DevTableViewCell *devtableviewcell = [tableView dequeueReusableCellWithIdentifier:@"DevTableViewCell"
                                                                         forIndexPath:indexPath];
    
    DevDataModel *devModel = [self.array objectAtIndex:indexPath.row];
    [devtableviewcell configWithItem:devModel];
    
    if ([devtableviewcell respondsToSelector:@selector(setLayoutMargins:)]) {
        [devtableviewcell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return devtableviewcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74.3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    DevDataModel *devModel = [self.array objectAtIndex:indexPath.row];
    detail.detailId = devModel.id;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}



@end
