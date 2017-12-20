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
#import "AssesstokenAPI.h"
#import "TopicsApi.h"
#import "UIColor+TitleColor.h"
#import "DetailTopView.h"
#import "DetailViewController.h"


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
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1/1.0]];

    TopicsApi *topApi = [[TopicsApi alloc] init];
    [topApi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        self.allModel = request.responseJSONObject;
        [self.tableView reloadData];
    }failure:NULL];
    
    
    __weak typeof(self) weakSelf = self;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNoreData];
    }];
    
    [self.tableView registerClass:[AllTableViewCell class] forCellReuseIdentifier:@"allTableViewCell"];
}

- (void)loadNewData{
    TopicsApi *topApi = [[TopicsApi alloc] init];
    [topApi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.allModel = request.responseJSONObject;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }failure:NULL];
}

- (void)loadNoreData{
    TopicsApi *topApi = [[TopicsApi alloc] init];
    [topApi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.allModel = request.responseJSONObject;
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }
                          failure:NULL];
}

- (void)viewWillAppear:(BOOL)animated
{
    TopicsApi *topApi = [[TopicsApi alloc] init];
    [topApi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        self.allModel = request.responseJSONObject;
        [self.tableView reloadData];
    }failure:NULL];
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
    
    self.allModel = [self.array objectAtIndex:indexPath.row];
    [allTableViewCell configWithItem:self.allModel];
    
    if ([allTableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [allTableViewCell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return allTableViewCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74.3;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc] init];
    self.allModel = [self.array objectAtIndex:indexPath.row];
    vc.detailId = self.allModel.id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}





@end
