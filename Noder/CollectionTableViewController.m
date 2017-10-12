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

@interface CollectionTableViewController ()

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CollectionAPI *collectionAPI = [[CollectionAPI alloc] init];
    collectionAPI.loginname = self.collectionLoginname;
    [collectionAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        NSDictionary *dicationary = request.responseJSONObject;
        
        self.array = dicationary[@"data"];
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
    
    if (!cell) {
        cell = [[CollectionCell alloc] initWithStyle:UITableViewCellStyleValue1
                                     reuseIdentifier:@"CollectionCell"];
    }
    
    NSDictionary *dicationary = [self.array objectAtIndex:indexPath.row];
    [cell configWithItem:dicationary];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.detailId = [self.array[indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
