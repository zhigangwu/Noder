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
#import "UIFont+SetFont.h"
#import "UIColor+TitleColor.h"
#import "HomePageController.h"
#import "RecentReplyViewController.h"
#import "RecentTopicsViewController.h"
#import "NewPageTableViewController.h"
#import "ControllerManager.h"


@interface SetPageViewController () <UITabBarControllerDelegate>

@end

@implementation SetPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"设置";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    UITableView *table = [[UITableView alloc] init];
    UIView *logoview = [[UIView alloc] init];
    UIImageView *logoimageview = [[UIImageView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:table];
    [self.view addSubview:logoview];
    [logoview addSubview:logoimageview];
    [logoview addSubview:label];
    [table mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(logoview.mas_top);
    }];
    
    [logoview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(table.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(343);
    }];
    
    [logoimageview mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(logoview);
        make.centerY.equalTo(logoview);
        make.size.mas_equalTo(CGSizeMake(112, 125));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(logoimageview);
        make.top.equalTo(logoimageview.mas_bottom).with.offset(104.6);
        make.height.mas_equalTo(18);
    }];
    
    logoview.backgroundColor = [UIColor backgroundcolor];
    
    logoimageview.image = [UIImage imageNamed:@"N"];
    
    label.text = @"V 10.0";
    label.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
    label.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1/1.0];
    
    //    cell分割线全屏
    if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
        table.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([table respondsToSelector:@selector(setLayoutMargins:)]) {
        table.layoutMargins = UIEdgeInsetsZero;
    }
    
    [table setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1/1.0]];
    table.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1/1.0];
    table.delegate = self;
    table.dataSource = self;
    table.scrollEnabled = NO;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    
    //    分割线全屏
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 20;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor backgroundcolor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            cell.textLabel.text = @"清理缓存";
        }
        if (indexPath.row == 1) {
//            cell.textLabel.text = @"个人博客";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://zhigangwu.github.io/"]];
        }
        if (indexPath.row == 2 ) {
//            cell.textLabel.text = @"Github";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/zhigangwu"]];
        }
    } else if (indexPath.section == 1){
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"确定退出"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:@"退出登入"
                                                        otherButtonTitles:nil, nil];
        [actionsheet showInView:tableView];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults removeObjectForKey:@"accesstoken"];
    [userdefaults synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
