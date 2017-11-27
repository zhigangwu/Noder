//
//  ShareViewController.m
//  Noder
//
//  Created by alienware on 2017/6/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareTableViewCell.h"
#import "ShareAPI.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "UIColor+tableBackground.h"
#import "ShareDataModel.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor tableBackground];
    
    ShareAPI *shareAPI = [[ShareAPI alloc] init];
    [shareAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;        
        [self.tableView reloadData];
    } failure:NULL];
    
    
    [self.tableView registerClass:[ShareTableViewCell class] forCellReuseIdentifier:@"shareTableViewCell"];
    
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
    ShareAPI *shareAPI = [[ShareAPI alloc] init];
    [shareAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:NULL];
}

- (void)loadNoreData
{
    ShareAPI *shareAPI = [[ShareAPI alloc] init];
    [shareAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:NULL];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShareTableViewCell *shareTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"shareTableViewCell" forIndexPath:indexPath];
    
    ShareDataModel *shareModel = [self.array objectAtIndex:indexPath.row];

    [shareTableViewCell configWithItem:shareModel];
    
    return shareTableViewCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc] init];
    ShareDataModel *shareModel = [self.array objectAtIndex:indexPath.row];
    vc.detailId = shareModel.id;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
