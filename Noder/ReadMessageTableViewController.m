//
//  ReadMessageTableViewController.m
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ReadMessageTableViewController.h"
#import "ReadMessageAPI.h"
#import "ControllerManager.h"
#import "ReadMessageCell.h"

@interface ReadMessageTableViewController ()

@end

@implementation ReadMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消系统自带的分割线
    self.tableView.backgroundColor = [UIColor colorWithWhite:215 / 255.0 alpha:0.3];
    
    ReadMessageAPI *readMesAPi = [[ReadMessageAPI alloc] init];
//    readMesAPi.requestArgument = @{@"accesstoken" : access,@"mdrender":};
    [readMesAPi startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        NSDictionary *dic = request.responseJSONObject;
        self.array = dic[@"data"];
        
        [self.tableView reloadData];
    } failure:NULL];
    
    [self.tableView registerClass:[ReadMessageCell class] forCellReuseIdentifier:@"ReadMessageCell"];
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
    ReadMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadMessageCell"
                                                            forIndexPath:indexPath];
    
    NSDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    
    [cell configWithItem:dictionary];
    
    return cell;
    
}

@end
