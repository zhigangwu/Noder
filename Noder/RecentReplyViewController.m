
//
//  RecentReplyViewController.m
//  Noder
//
//  Created by alienware on 2017/5/22.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "RecentReplyViewController.h"
#import "RecentReplyCell.h"
#import "Masonry.h"
#import "Loginapi.h"
#import "DetailViewController.h"
#import "UIColor+tableBackground.h"

@interface RecentReplyViewController ()

@end

@implementation RecentReplyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消系统自带的分割线
    self.tableView.backgroundColor = [UIColor tableBackground];
    
    Loginapi *recentAPI = [[Loginapi alloc] init];
    recentAPI.loginname = self.recenrLoginname;
    [recentAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        
        self.loginModel = request.responseJSONObject;
        self.array = self.loginModel.recent_replies;
        
        [self.tableView reloadData];
    } failure:NULL];
    
    [self.tableView registerClass:[RecentReplyCell class] forCellReuseIdentifier:@"RecentReplyCell"];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecentReplyCell *recentreplyCell = [tableView dequeueReusableCellWithIdentifier:@"RecentReplyCell"
                                                                     forIndexPath:indexPath];

//    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
     self.recent_replies = [self.array objectAtIndex:indexPath.row];
    
    [recentreplyCell configWithItem:self.recent_replies];
    
    return recentreplyCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    self.recent_replies = [self.array objectAtIndex:indexPath.row];
    detail.detailId = self.recent_replies.id;
    [self.navigationController pushViewController:detail animated:YES];
}








@end
