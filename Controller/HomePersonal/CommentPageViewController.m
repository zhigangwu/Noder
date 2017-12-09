//
//  CommentPageTableViewController.m
//  Noder
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "CommentPageViewController.h"
#import "Masonry.h"
#import "ComContentViewContrnt.h"
#import "ControllerManager.h"
#import "PersonalComViewController.h"
#import "MJRefresh.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJExtension.h"
#import "comContentAPI.h"
#import "UIColor+tableBackground.h"
#import "DetailApi.h"
#import "UIFont+SetFont.h"


@implementation CommentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
    //去掉返回按钮中的back
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconGrayComment"]
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(comCenterButton:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.tableview = [[UITableView alloc] init];
    [self.view addSubview:self.tableview];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.tableview.delegate = self;
    self.tableview.dataSource =self;
    
    [self.tableview registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"CommentTableViewCell"];
    
    //  cell自适应高度 注:需要把cell上的控件自上而下加好约束
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 200;
    
    //    cell分割线全屏
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableview.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableview.layoutMargins = UIEdgeInsetsZero;
    }
    
    if ([ControllerManager shareManager].success == false) {
        self.rightButton.hidden = YES;
    }
    
    [self setupRefresh];
    
    DetailApi *detailAPI = [[DetailApi alloc] init];
    detailAPI._id = self.topic_id;
    [detailAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.detailModel = request.responseJSONObject;
        self.array = self.detailModel.replies;
        [self.tableview reloadData];
    } failure:nil];
}

- (void)setupRefresh
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableview addSubview:refresh];
    
    [refresh beginRefreshing];
    
    [self refreshStateChange:refresh];
}

- (void)refreshStateChange:(UIRefreshControl *)refresh
{
    [self.tableview reloadData];
    [refresh endRefreshing];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableview reloadData];
}

- (void)comCenterButton:(UIButton *)sender
{
    if ([ControllerManager shareManager].success == 1) {
        ComContentViewContrnt *comContentVC = [[ComContentViewContrnt alloc] init];
        [self.navigationController pushViewController:comContentVC animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请登入"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)comcontent
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.CommentCellDelegate = self;
    cell.PersonalCommentDelegate = self;
    cell.floorLabel.text = [NSString stringWithFormat:@"%ld楼",indexPath.row + 1];
    
//    for (int i = 1; i < self.array.count ; i++) {
//        cell.floorLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//        NSLog(@"******%ld",indexPath.row);
//    }
    
    self.reply = [self.array objectAtIndex:indexPath.row];
//    NSLog(@"reply = %@",self.reply.id);
    [cell configWithItem:self.reply];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    return cell;
}

- (void)evaluation:(id)sender
{
    PersonalComViewController *personal = [[PersonalComViewController alloc] init];
    personal.reply_id = self.detailModel.id;
    [self.navigationController pushViewController:personal animated:YES];
}

- (void)upButton:(UIButton *)sender
{
    if ([ControllerManager shareManager].success == true) {
        CommentTableViewCell *cell = (CommentTableViewCell *)[[sender superview] superview];
        NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
        self.reply = [self.array objectAtIndex:indexPath.row];

        ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
        thumAPI.reply_id = self.reply.id;
        NSString *access = [ControllerManager shareManager].string;
        if (access != nil) {
            thumAPI.requestArgument = @{@"accesstoken" : access};
            [thumAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
                self.thumbsModel = request.responseJSONObject;
                NSLog(@"self.thumbsModel = %@",self.thumbsModel);
                [self.tableview reloadData];
            } failure:NULL];
        }
    } else {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请登入"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil, nil];
        [alertview show];
    }
}

- (void)personalComButton:(UIButton *)sender
{
    if ([ControllerManager shareManager].success == true) {
        ComContentViewContrnt *comContentVC = [[ComContentViewContrnt alloc] init];
        [self.navigationController pushViewController:comContentVC animated:YES];
    } else {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请登入"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil, nil];
        [alertview show];
    }
}






	
@end
