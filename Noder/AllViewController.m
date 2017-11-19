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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消系统自带的分割线
    self.tableView.backgroundColor = [UIColor tableBackground];
    
    TopicsApi *topApi = [[TopicsApi alloc] init];
    [topApi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
//        NSDictionary *dicationary = request.responseJSONObject;
//        NSLog(@"%@",dicationary);
//        self.array = dicationary[@"data"];

        self.array = request.responseJSONObject;
        NSLog(@"self.array = %@",self.array);
        

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
        NSDictionary *dicationary = request.responseJSONObject;
        
        self.array = dicationary[@"data"];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }
                          failure:NULL];
    
}

- (void)loadNoreData{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    });

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
    
//    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    AllViewDataModel *allModel = [self.array objectAtIndex:indexPath.row];
    
//    [allTableViewCell configWithItem:dictionary];
    [allTableViewCell configWithItem:allModel];
    
    return allTableViewCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.7;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc] init];
//    Topic *topic = [[Topic alloc] init];
    vc.detailId = [self.array[indexPath.row] objectForKey:@"id"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
