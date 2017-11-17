//
//  UnreadMessageTableViewController.m
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "UnreadMessageTableViewController.h"
#import "UnreadMessageAPI.h"
#import "UnreadMessageCell.h"
#import "ControllerManager.h"

@interface UnreadMessageTableViewController ()

@end

@implementation UnreadMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消系统自带的分割线
    self.tableView.backgroundColor = [UIColor colorWithWhite:215 / 255.0 alpha:0.3];
    
    NSString *access = [ControllerManager shareManager].string;
    
    UnreadMessageAPI *UnreadMesAPI = [[UnreadMessageAPI alloc] init];
    if (access != nil) {
        UnreadMesAPI.requestArgument = @{@"accesstoken" : access};
        [UnreadMesAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
            NSDictionary *dictionary = request.responseJSONObject;
            NSLog(@"dictionary = %@",dictionary);
            self.array = dictionary[@"data"];
            
            [self.tableView reloadData];
        } failure:NULL];
    }

    [self.tableView registerClass:[UnreadMessageCell class] forCellReuseIdentifier:@"UnreadMessageCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnreadMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnreadMessageCell"
                                                              forIndexPath:indexPath];
    
    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    
    [cell configWithItem:dictionary];
    
    return cell;
}


@end
