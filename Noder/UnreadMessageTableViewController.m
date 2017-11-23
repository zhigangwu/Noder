//
//  UnreadMessageTableViewController.m
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "UnreadMessageTableViewController.h"
#import "UnreadMessageCell.h"
#import "ControllerManager.h"
#import "UIColor+tableBackground.h"
#import "MessageAPI.h"

@interface UnreadMessageTableViewController ()

@end

@implementation UnreadMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消系统自带的分割线
    self.tableView.backgroundColor = [UIColor tableBackground];
    
    NSString *accesstoken = [ControllerManager shareManager].string;
    MessageAPI *messageAPI = [[MessageAPI alloc] init];
    if (accesstoken != nil) {
        messageAPI.requestArgument = @{@"accesstoken" : accesstoken};
        [messageAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
            self.messageModel = request.responseJSONObject;
            self.array = self.messageModel.hasnot_read_messages;
            
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
    
    Hasnot_read_messages *hasnot_read = [self.array objectAtIndex:indexPath.row];
    
    [cell configWithItem:hasnot_read];
    
    return cell;
}


@end
