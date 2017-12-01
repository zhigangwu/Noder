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


@implementation CommentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    cell分割线全屏
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navIconBackDefault"]
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(backView)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.rightButton = [[UIButton alloc] init];
    [self.view addSubview:_rightButton];
    _rightButton.frame = CGRectMake(0, 0, 40, 40);
    [_rightButton setTitle:@"评价" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [_rightButton addTarget:self action:@selector(appraise) forControlEvents:UIControlEventTouchUpInside];

    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"CommentTableViewCell"];
    
    //  cell自适应高度 注:需要把cell上的控件自上而下加好约束
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    
    if ([ControllerManager shareManager].success == false) {
        self.rightButton.hidden = YES;
    }
    
    [self setupRefresh];
    
    DetailApi *detailAPI = [[DetailApi alloc] init];
    detailAPI._id = self.topic_id;
    [detailAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.detailModel = request.responseJSONObject;
        self.array = self.detailModel.replies;
        [self.tableView reloadData];
    } failure:nil];
    
}

- (void)setupRefresh
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    
    [refresh beginRefreshing];
    
    [self refreshStateChange:refresh];
}

- (void)refreshStateChange:(UIRefreshControl *)refresh
{
    [self.tableView reloadData];
    [refresh endRefreshing];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)appraise
{
    ComContentViewContrnt *comConent = [[ComContentViewContrnt alloc] init];
    comConent.topic_id = self.topic_id;
    comConent.reply_id = _reply_id;
    [self.navigationController pushViewController:comConent animated:YES];
}

- (void)backView
{
    self.bottomViem = [[DetailBottomView alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
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
    cell.delegate = self;
    
    DetailReplies *replies = [self.array objectAtIndex:indexPath.row];
    [cell configWithItem:replies];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 400;
//}

- (void)evaluation:(id)sender
{
    PersonalComViewController *personal = [[PersonalComViewController alloc] init];
    personal.reply_id = self.detailModel.id;
    [self.navigationController pushViewController:personal animated:YES];
}

- (void)pushToNewPage:(UIButton *)sender
{
    CommentTableViewCell *cell = (CommentTableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.detailModel = [self.array objectAtIndex:indexPath.row];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"replyid" object:self.detailModel.id];

    ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
    thumAPI.reply_id = self.detailModel.id;
    NSString *access = [ControllerManager shareManager].string;
    thumAPI.requestArgument = @{@"accesstoken" : access};
    [thumAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        self.thumbsModel = request.responseJSONObject;
    } failure:NULL];

}





	
@end
