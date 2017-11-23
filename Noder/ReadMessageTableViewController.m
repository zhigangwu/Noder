//
//  ReadMessageTableViewController.m
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ReadMessageTableViewController.h"
#import "ControllerManager.h"
#import "ReadMessageCell.h"
#import "UIColor+tableBackground.h"
#import "MessageAPI.h"
#import "MessageCountAPI.h"

@interface ReadMessageTableViewController ()

@end

@implementation ReadMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消系统自带的分割线
    self.tableView.backgroundColor = [UIColor tableBackground];
    
    NSString *accesstoken = [ControllerManager shareManager].string;
    MessageAPI *messAPI = [[MessageAPI alloc] init];
    MessageCountAPI *countAPI = [[MessageCountAPI alloc] init];
    
    if (accesstoken != nil) {
        messAPI.requestArgument = @{@"accesstoken" : accesstoken};
        [messAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){

            self.messageModel  = request.responseJSONObject;
            self.array = self.messageModel.has_read_messages;
            
            [self.tableView reloadData];
        } failure:NULL];
    }
    
    if (accesstoken != nil) {
        countAPI.requestArgument = @{@"accesstoken" : accesstoken};
        [countAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
            NSDictionary *dic = request.responseJSONObject;
            NSLog(@"^^^^^%@",dic);
            [self.tableView reloadData];
        } failure:NULL];
    }

    
    [self.tableView registerClass:[ReadMessageCell class] forCellReuseIdentifier:@"ReadMessageCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadMessageCell"
                                                            forIndexPath:indexPath];
    
     Has_read_messages *has_read = [self.array objectAtIndex:indexPath.row];
    [cell configWithItem:has_read];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.4;
}


@end
