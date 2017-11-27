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
    
    //    cell分割线全屏
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }

    NSString *accesstoken = [ControllerManager shareManager].string;
    MessageAPI *messAPI = [[MessageAPI alloc] init];
    
    if (accesstoken != nil) {
        messAPI.requestArgument = @{@"accesstoken" : accesstoken};
        [messAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){

            self.messageModel  = request.responseJSONObject;
            self.array = self.messageModel.has_read_messages;
            
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


@end
