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
#import "UIColor+TitleColor.h"
#import "MessageAPI.h"
#import "NullView.h"
#import "Masonry.h"
#import "UIFont+SetFont.h"
#import "MarkReadAPI.h"

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
    self.view.backgroundColor = [UIColor whiteColor];

    //去掉返回按钮中的back
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    self.tableview = [[UITableView alloc] init];
    self.nullview = [[NullView alloc] init];
    

    NSString *accesstoken = [ControllerManager shareManager].string;
    MessageAPI *messageAPI = [[MessageAPI alloc] init];
    if (accesstoken != nil) {
        messageAPI.requestArgument = @{@"accesstoken" : accesstoken};
        [messageAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
            self.messageModel = request.responseJSONObject;
            self.array = self.messageModel.hasnot_read_messages;
//            NSLog(@"array= %@",self.array);
            if (self.array == nil) {
                self.tableview.hidden = YES;
                [self.view addSubview:self.nullview];
                [self.nullview mas_makeConstraints:^(MASConstraintMaker *make){
                    make.top.equalTo(self.view);
                    make.left.equalTo(self.view);
                    make.right.equalTo(self.view);
                    make.bottom.equalTo(self.view);
                }];
            } else {
                self.nullview.hidden = YES;
                [self.view addSubview:self.tableview];
                [self.tableview mas_makeConstraints:^(MASConstraintMaker *make){
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
                
                //  cell自适应高度 注:需要把cell上的控件自上而下加好约束
                self.tableview.rowHeight = UITableViewAutomaticDimension;
                self.tableview.estimatedRowHeight = 100;
                self.tableview.delegate = self;
                self.tableview.dataSource = self;
            }
//            [self.tableview reloadData];
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
        return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnreadMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnreadMessageCell"
                                                              forIndexPath:indexPath];
    
    self.hasnot_read = [self.array objectAtIndex:indexPath.row];
    
    [cell configWithItem:self.hasnot_read];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        MarkReadAPI *markAPI = [[MarkReadAPI alloc] init];
        markAPI.msg_id = self.hasnot_read.id;
        markAPI.requestArgument = @{@"accesstoken" : [ControllerManager shareManager].string};
        if ([ControllerManager shareManager].string != nil) {
            [markAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
//                NSLog(@"****%@",request.responseJSONObject);
            } failure:nil];
        }
        NSMutableArray *mutableArray = [self.array mutableCopy];
        [mutableArray removeObjectAtIndex:indexPath.row];
        [self.tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"已读";
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}




@end
