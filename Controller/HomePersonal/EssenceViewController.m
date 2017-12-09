//
//  EssenceViewController.m
//  Noder
//
//  Created by alienware on 2017/6/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "EssenceViewController.h"
#import "EssenceTableViewCell.h"
#import "EssenceAPI.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "UIColor+tableBackground.h"
#import "EssenceDataModel.h"

@interface EssenceViewController ()

@end

@implementation EssenceViewController

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
    
    EssenceAPI *essenceAPI = [[EssenceAPI alloc] init];
    [essenceAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        [self.tableView reloadData];
    }
                              failure:NULL];

    [self.tableView registerClass:[EssenceTableViewCell class] forCellReuseIdentifier:@"essenceTableViewCell"];
    
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
    EssenceAPI *essenceAPI = [[EssenceAPI alloc] init];
    [essenceAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }
                          failure:NULL];

}

- (void)loadNoreData{
    EssenceAPI *essenceAPI = [[EssenceAPI alloc] init];
    [essenceAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }
                              failure:NULL];
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
    EssenceTableViewCell *essenceTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"essenceTableViewCell" forIndexPath:indexPath];

    EssenceDataModel *essenceModel = [self.array objectAtIndex:indexPath.row];
    [essenceTableViewCell configWithItem:essenceModel];
    
    if ([essenceTableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [essenceTableViewCell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return essenceTableViewCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74.3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc] init];
    EssenceDataModel *essenceModel = [self.array objectAtIndex:indexPath.row];
    vc.detailId = essenceModel.id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

















@end
