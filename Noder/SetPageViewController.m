//
//  SetPageViewController.m
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "SetPageViewController.h"

#import "PersonalCenterViewController.h"
#import "AppDelegate.h"



@interface SetPageViewController ()

@end

@implementation SetPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] init];
    [self.view addSubview:table];
    [table mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(234);
    }];

    table.delegate = self;
    table.dataSource = self;
    
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 1;
    }
    return section;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"清理缓存";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"个人博客";
        }
        if (indexPath.row == 2 ) {
            cell.textLabel.text = @"Github";
        }
    } else if (indexPath.section == 1){
        cell.textLabel.text = @"退出登入";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            cell.textLabel.text = @"清理缓存";
        }
        if (indexPath.row == 1) {
//            cell.textLabel.text = @"个人博客";
        }
        if (indexPath.row == 2 ) {
//            cell.textLabel.text = @"Github";
        }
    } else if (indexPath.section == 1){
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

@end
