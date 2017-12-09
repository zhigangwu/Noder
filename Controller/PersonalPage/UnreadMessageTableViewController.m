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
#import "NullView.h"
#import "Masonry.h"
#import "UIFont+SetFont.h"
#import "UIColor+background.h"

@interface UnreadMessageTableViewController ()

@property (nonatomic, strong) NullView *nullview;

@end

@implementation UnreadMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"未读消息";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;

    //去掉返回按钮中的back
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    self.tableview = [[UITableView alloc] init];
    self.nullview = [[NullView alloc] init];
    
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.nullview];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.nullview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    //    cell分割线全屏
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableview.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableview.layoutMargins = UIEdgeInsetsZero;
    }

    NSString *accesstoken = [ControllerManager shareManager].string;
    MessageAPI *messageAPI = [[MessageAPI alloc] init];
    if (accesstoken != nil) {
        messageAPI.requestArgument = @{@"accesstoken" : accesstoken};
        [messageAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
            self.messageModel = request.responseJSONObject;
            self.array = self.messageModel.hasnot_read_messages;
            
            [self.tableview reloadData];
        } failure:NULL];
    }
    
    [self.tableview registerClass:[UnreadMessageCell class] forCellReuseIdentifier:@"UnreadMessageCell"];
    
    //不显示空白cell
    UIView *footview = [[UIView alloc] init];
    footview.backgroundColor = [UIColor backgroundcolor];
    self.tableview.tableFooterView = footview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.array == nil) {
        
        self.tableview.hidden = YES;
    }
        return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnreadMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnreadMessageCell"
                                                              forIndexPath:indexPath];
    
    Hasnot_read_messages *hasnot_read = [self.array objectAtIndex:indexPath.row];
    
    [cell configWithItem:hasnot_read];
    
    //    分割线全屏
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    
    return cell;
}


@end
