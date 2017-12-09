//
//  RecruitmentViewController.m
//  Noder
//
//  Created by alienware on 2017/6/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "RecruitmentViewController.h"
#import "RecruitmentTableViewCell.h"
#import "JobAPI.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "UIColor+tableBackground.h"
#import "JobDataModel.h"

@interface RecruitmentViewController ()

@end

@implementation RecruitmentViewController

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
    
    JobAPI *jobAPI = [[JobAPI alloc] init];
    [jobAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        [self.tableView reloadData];
    } failure:NULL];
    
    [self.tableView registerClass:[RecruitmentTableViewCell class] forCellReuseIdentifier:@"recruitmentTableViewCell"];
    
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
    JobAPI *jobAPI = [[JobAPI alloc] init];
    [jobAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:NULL];

}

- (void)loadNoreData
{
    JobAPI *jobAPI = [[JobAPI alloc] init];
    [jobAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
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
    RecruitmentTableViewCell *recruitmentTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"recruitmentTableViewCell" forIndexPath:indexPath];
    
    JobDataModel *jobModel = [self.array objectAtIndex:indexPath.row];
    [recruitmentTableViewCell configWithItem:jobModel];
    
    if ([recruitmentTableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [recruitmentTableViewCell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return recruitmentTableViewCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74.3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc] init];
    JobDataModel *jobModel = [self.array objectAtIndex:indexPath.row];
    vc.detailId = jobModel.id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}





@end
