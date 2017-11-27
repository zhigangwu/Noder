//
//  RecentTopicsViewController.m
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "RecentTopicsViewController.h"
#import "RecentTopicsCell.h"
#import "Loginapi.h"
#import "DetailViewController.h"
#import "UIColor+tableBackground.h"

@interface RecentTopicsViewController ()

@end

@implementation RecentTopicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    //    cell分割线全屏
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }

    Loginapi *recentTopics = [[Loginapi alloc] init];
    recentTopics.loginname = self.TopicsLoginname;
    [recentTopics startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        
        self.loginModel = request.responseJSONObject;
        self.array = self.loginModel.recent_topics;
        
        [self.tableView reloadData];        
    } failure:NULL];
    
    [self.tableView registerClass:[RecentTopicsCell class] forCellReuseIdentifier:@"RecentTopicsCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecentTopicsCell *recenttopicsCell = [tableView dequeueReusableCellWithIdentifier:@"RecentTopicsCell"
                                                                       forIndexPath:indexPath];
    if (!recenttopicsCell) {
        recenttopicsCell = [[RecentTopicsCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                 reuseIdentifier:@"RecentTopicsCell"];
    }
    
    self.recent_topics = [self.array objectAtIndex:indexPath.row];
    [recenttopicsCell configWithItem:self.recent_topics];
    
    //    分割线全屏
    if ([recenttopicsCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [recenttopicsCell setLayoutMargins:UIEdgeInsetsZero];
    }

    
    return recenttopicsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    self.recent_topics = [self.array objectAtIndex:indexPath.row];
    detail.detailId = self.recent_topics.id;
    [self.navigationController pushViewController:detail animated:YES];
}


@end
