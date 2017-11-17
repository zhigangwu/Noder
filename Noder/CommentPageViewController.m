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




@interface CommentPageViewController ()


@property (nonatomic, strong) NSMutableArray *listArry;

@end

@implementation CommentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.rightButton = [[UIButton alloc] init];
    [self.view addSubview:_rightButton];
    _rightButton.frame = CGRectMake(0, 0, 40, 40);
    [_rightButton setTitle:@"评价" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;

    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"CommentTableViewCell"];
    
    NSDictionary *dic = [ControllerManager shareManager].dictionary;
    NSString *success = dic[@"success"];
    if (success.boolValue == false) {
        self.rightButton.hidden = YES;
    }

    [_rightButton addTarget:self action:@selector(appraise) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupRefresh];
    
    [self AccessNetworkForDateMethod];
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
//    return self.listAarry.count;
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    
    cell.delegate = self;
    
    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    [cell configWithItem:dictionary];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)AccessNetworkForDateMethod
{
    NSDictionary *array = self.dictionary[@"data"];
    self.array = [array valueForKey:@"replies"];
    _reply_id = [self.array valueForKey:@"id"];
    _topic_id = [array valueForKey:@"id"];
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
//    CommentTableViewCell *cell = (CommentTableViewCell *)[[sender superview] superview];
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
//    _string_id = dictionary[@"id"];
//    NSLog(@"^^^^^^%@",_string_id);
//    [ControllerManager shareManager].reply_ID = _reply_id;
    
    PersonalComViewController *personal = [[PersonalComViewController alloc] init];
    personal.reply_id = _string_id;
    [self.navigationController pushViewController:personal animated:YES];
    
}

- (void)pushToNewPage:(UIButton *)sender
{
    
    NSLog(@"%@",sender);
    
    CommentTableViewCell *cell = (CommentTableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    self.string_id = dictionary[@"id"];
    //    NSLog(@"^^^^^^%@",dictionary);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"replyid" object:self.string_id];

    ThumbsUpAPI *thumAPI = [[ThumbsUpAPI alloc] init];
    thumAPI.reply_id = self.string_id;
    NSString *access = [ControllerManager shareManager].string;
    thumAPI.requestArgument = @{@"accesstoken" : access};
    [thumAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        NSDictionary *dic = request.responseJSONObject;
        NSLog(@"dic = %@",dic);
    } failure:NULL];

}





	
@end
