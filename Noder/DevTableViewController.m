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

@interface DevTableViewController ()

@end

@implementation DevTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DevAPI *devAPI = [[DevAPI alloc] init];
    [devAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        NSDictionary *dictionary = request.responseJSONObject;
        
        self.array = dictionary[@"data"];
        
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

- (void)loadNewData{
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    });
}

- (void)loadNoreData{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    });
    
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
    
    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    
    [devtableviewcell configWithItem:dictionary];
    
    return devtableviewcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.detailId = [self.array[indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:detail animated:YES];
}



@end
