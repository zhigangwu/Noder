//
//  CommentPageTableViewController.m
//  Noder
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "CommentPageViewController.h"
#import "CommentTableViewCell.h"
#import "Masonry.h"
#import "ComContentViewContrnt.h"
#import "ControllerManager.h"
#import "PersonalComViewController.h"
#import "MJRefresh.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJExtension.h"
#import "comContentAPI.h"

#import "ThumbsUpAPI.h"

@interface CommentPageViewController ()

@property (nonatomic, strong) NSMutableArray *listArry;

@end

@implementation CommentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self AccessNetworkForDateMethod];

    self.rightButton = [[UIButton alloc] init];
    [self.view addSubview:_rightButton];
    _rightButton.frame = CGRectMake(0, 0, 40, 40);
    [_rightButton setTitle:@"评价" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;

    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    self.tableView.fd_debugLogEnabled = YES;
    static NSString *string = @"CommentTableViewCell";
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:string];
    
    
    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNoreData];
    }];

}

- (void)loadNewData{
    
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    });
}

- (void)loadNoreData{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    });
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *string = @"CommentTableViewCell";
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    [cell configWithItem:dictionary];
    
    
    NSDictionary *dic = [ControllerManager shareManager].dictionary;
    NSString *success = dic[@"success"];
    
    if (success.boolValue == true) {
        [_rightButton addTarget:self action:@selector(appraise) forControlEvents:UIControlEventTouchUpInside];
        self.ZG_evaButton = cell.ZGevaButton;
        [_ZG_evaButton addTarget:self action:@selector(evaluation) forControlEvents:UIControlEventTouchUpInside];
        self.ZG_upButton = cell.ZGupButton;
        [_ZG_upButton addTarget:self action:@selector(praise) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.rightButton setHidden:YES];
        self.ZG_evaButton = cell.ZGevaButton;
        [_ZG_evaButton setHidden:YES];
        self.ZG_upButton = cell.ZGupButton;
        [_ZG_upButton setHidden:YES];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [self.tableview fd_heightForCellWithIdentifier:@"CommentTableViewCell"
//                                               cacheByKey:indexPath
//                                            configuration:^(CommentTableViewCell *cell){
//                                                cell.cellModel = _listArry[indexPath.row];
//                                            }];
    return 400;
}

- (void)AccessNetworkForDateMethod
{
    NSArray *array = self.dictionary[@"data"];
    _array = [array valueForKey:@"replies"];
    _reply_id = [self.array valueForKey:@"id"];
    _topic_id = [array valueForKey:@"id"];
    
    comContentAPI *comAPI = [[comContentAPI alloc] init];
    comAPI.topic_id = _topic_id;
    
    if (!_listArry){
        _listArry = [NSMutableArray array];
    }
    _listArry = _array;
    
    [self.tableView reloadData];
}

- (void)appraise
{
    ComContentViewContrnt *comConent = [[ComContentViewContrnt alloc] init];
    comConent.topic_id = self.topic_id;
    comConent.reply_id = _reply_id;
    [self.navigationController pushViewController:comConent animated:YES];
}

- (void)evaluation
{
    PersonalComViewController *personal = [[PersonalComViewController alloc] init];
    personal.reply_id = _reply_id;
    [self.navigationController pushViewController:personal animated:YES];
  
}

- (void)praise
{
    ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
    thumAPI.reply_id = _reply_id;
    NSString *access = [ControllerManager shareManager].string;
    thumAPI.requestArgument = @{@"accesstoken" : access};
    [thumAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        NSDictionary *dic = request.responseJSONObject;
        NSLog(@"dic = %@",dic);
    } failure:NULL];
}





	
@end
