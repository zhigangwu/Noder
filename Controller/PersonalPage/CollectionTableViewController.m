//
//  CollectionTableViewController.m
//  Noder
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "CollectionAPI.h"
#import "CollectionCell.h"
#import "DetailViewController.h"
#import "UIColor+tableBackground.h"

#import "CollectionDataModel.h"

@interface CollectionTableViewController ()

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    cell分割线全屏
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }

    CollectionAPI *collectionAPI = [[CollectionAPI alloc] init];
    collectionAPI.loginname = self.collectionLoginname;
    [collectionAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){

        self.array = request.responseJSONObject;
        [self.tableView reloadData];
        
    }failure:NULL];

    [self.tableView registerClass:[CollectionCell class] forCellReuseIdentifier:@"CollectionCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell"
                                                           forIndexPath:indexPath];
    
    CollectionDataModel *collectionModel = [self.array objectAtIndex:indexPath.row];
    [cell configWithItem:collectionModel];
    
    //    分割线全屏
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    CollectionDataModel *collectionModel = [self.array objectAtIndex:indexPath.row];
    detail.detailId = collectionModel.id;
    [self.navigationController pushViewController:detail animated:YES];
}


@end
