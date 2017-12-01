//
//  QandAViewController.m
//  Noder
//
//  Created by alienware on 2017/6/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "QandAViewController.h"
#import "QandATableViewCell.h"
#import "AskAPI.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "UIColor+tableBackground.h"
#import "AskDataModel.h"

@interface QandAViewController ()

@end

@implementation QandAViewController

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
    
    AskAPI *askAPi = [[AskAPI alloc] init];
    [askAPi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        
        [self.tableView reloadData];
    } failure:NULL];
    
    
    [self.tableView registerClass:[QandATableViewCell class] forCellReuseIdentifier:@"QandATableViewCell"];
    
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
    AskAPI *askAPi = [[AskAPI alloc] init];
    [askAPi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.array = request.responseJSONObject;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:NULL];

}

- (void)loadNoreData
{
    AskAPI *askAPi = [[AskAPI alloc] init];
    [askAPi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
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
    QandATableViewCell *QandATableViewCell = [tableView dequeueReusableCellWithIdentifier:@"QandATableViewCell" forIndexPath:indexPath];
    
    AskDataModel *askModel = [self.array objectAtIndex:indexPath.row];
    [QandATableViewCell configWithItem:askModel];
    
    if ([QandATableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [QandATableViewCell setLayoutMargins:UIEdgeInsetsZero];
    }

    return QandATableViewCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc] init];
    AskDataModel *askModel = [self.array objectAtIndex:indexPath.row];
    vc.detailId = askModel.id;
    [self.navigationController pushViewController:vc animated:YES];
}






@end
