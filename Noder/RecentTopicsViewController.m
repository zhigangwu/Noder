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

@interface RecentTopicsViewController ()

@end

@implementation RecentTopicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Loginapi *recentTopics = [[Loginapi alloc] init];
    recentTopics.loginname = self.TopicsLoginname;
    [recentTopics startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        NSDictionary *dictionary = request.responseJSONObject;
        NSArray *array = dictionary[@"data"];
        self.array = [array valueForKey:@"recent_topics"];
        
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
    
    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
//    recenttopicsCell.textLabel.text = [dictionary objectForKey:@"title"];
    [recenttopicsCell configWithItem:dictionary];
    
    return recenttopicsCell;
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
