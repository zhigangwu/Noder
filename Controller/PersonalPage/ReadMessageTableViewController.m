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
#import "UIFont+SetFont.h"
#import "UIColor+background.h"

@interface ReadMessageTableViewController ()

@end

@implementation ReadMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"已读消息";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;

    self.view.backgroundColor = [UIColor backgroundcolor];
    
    //  cell自适应高度 注:需要把cell上的控件自上而下加好约束
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    //去掉返回按钮中的back
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    //不显示空白cell
    UIView *footview = [[UIView alloc] init];
    footview.backgroundColor = [UIColor backgroundcolor];
    self.tableView.tableFooterView = footview;
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    //    cell分割线全屏
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        self.tableView.separatorInset = UIEdgeInsetsZero;
//    }
//
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        self.tableView.layoutMargins = UIEdgeInsetsZero;
//    }

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
    
//    //    分割线全屏
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
    
    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}


@end
