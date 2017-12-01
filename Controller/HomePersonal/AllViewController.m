//
//  AllViewController.m
//  Noder
//
//  Created by alienware on 2017/6/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "AllViewController.h"
#import "AllTableViewCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "AssesstokenAPI.h"
#import "TopicsApi.h"
#import "UIColor+tableBackground.h"



@interface AllViewController ()

@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    cell分割线全屏
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }

    TopicsApi *topApi = [[TopicsApi alloc] init];
    [topApi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        
        [self.tableView reloadData];
    }
                          failure:NULL];
    
    __weak typeof(self) weakSelf = self;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNoreData];
    }];
    
    [self.tableView registerClass:[AllTableViewCell class] forCellReuseIdentifier:@"allTableViewCell"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)loadNewData{
    
    TopicsApi *topApi = [[TopicsApi alloc] init];
    [topApi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }
                          failure:NULL];
    
}

- (void)loadNoreData{
    TopicsApi *topApi = [[TopicsApi alloc] init];
    [topApi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }
                          failure:NULL];
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
    AllTableViewCell *allTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"allTableViewCell" forIndexPath:indexPath];
    
    AllViewDataModel *allModel = [self.array objectAtIndex:indexPath.row];
    [allTableViewCell configWithItem:allModel];
    
    if ([allTableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [allTableViewCell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return allTableViewCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.7;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc] init];
    AllViewDataModel *allModel = [self.array objectAtIndex:indexPath.row];
    vc.detailId = allModel.id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
