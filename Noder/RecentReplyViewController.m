
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

@interface RecentReplyViewController ()

@end

@implementation RecentReplyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Loginapi *recentAPI = [[Loginapi alloc] init];
    recentAPI.loginname = self.recenrLoginname;
    [recentAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        NSDictionary *dictionary = request.responseJSONObject;

        NSArray *array = dictionary[@"data"];
        		
        self.array = [array valueForKey:@"recent_replies"];
        
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

    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    
    [recentreplyCell configWithItem:dictionary];
    
    return recentreplyCell;
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
