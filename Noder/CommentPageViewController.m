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
    
    [self setupRefresh];
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
        [_ZG_evaButton addTarget:self action:@selector(evaluation:) forControlEvents:UIControlEventTouchUpInside];
        self.ZG_upButton = cell.ZGupButton;
        [_ZG_upButton addTarget:self action:@selector(praise:) forControlEvents:UIControlEventTouchUpInside];
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
    return 200;
}

- (void)AccessNetworkForDateMethod
{
    NSArray *array = self.dictionary[@"data"];
    NSLog(@"array = %@",array);
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

- (void)evaluation:(id)sender
{
    CommentTableViewCell *cell = (CommentTableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    _string_id = dictionary[@"id"];
//    NSLog(@"^^^^^^%@",_string_id);
    [ControllerManager shareManager].reply_ID = _reply_id;
    
    PersonalComViewController *personal = [[PersonalComViewController alloc] init];
    personal.reply_id = _reply_id;
    [self.navigationController pushViewController:personal animated:YES];
    
}

- (void)praise:(UIButton *)sender
{
    CommentTableViewCell *cell = (CommentTableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    _string_id = dictionary[@"id"];
//    NSLog(@"^^^^^^%@",_string_id);

    
    _thumAPI.reply_id = _string_id;
    NSString *access = [ControllerManager shareManager].string;
    _thumAPI.requestArgument = @{@"accesstoken" : access};
    [_thumAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        NSDictionary *dic = request.responseJSONObject;
        NSLog(@"dic = %@",dic);
    } failure:NULL];
}





	
@end
