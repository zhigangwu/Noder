//
//  PlateSelectionViewController.m
//  Noder
//
//  Created by Mac on 2017/9/27.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "PlateSelectionViewController.h"
#import "PlateSelectionCell.h"
#import "Masonry.h"

@interface PlateSelectionViewController ()

@end

@implementation PlateSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view).with.offset(-10);
        make.height.mas_equalTo(350);
    }];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[PlateSelectionCell class] forCellReuseIdentifier:@"cell"];
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
        return 5;
    }
    if (section == 1) {
        return 1;
    }
    return section;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlateSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.label.font = [UIFont fontWithName:@".AppleSystemUIFont" size:13];
            cell.label.textColor = [UIColor colorWithRed:143/255.0 green:142/255.0 blue:148/255.0 alpha:1/1.0];
            cell.label.text = @"选择板块";
        }
        if (indexPath.row == 1){
            cell.label.text = @"分享";
        }
        if (indexPath.row == 2){
            cell.label.text = @"问答";
        }
        if (indexPath.row == 3){
            cell.label.text = @"招聘";
        }
        if (indexPath.row == 4){
            cell.label.text = @"客户端测试";
        }
    }
    if (indexPath.section == 1){
        cell.label.text = @"取消";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlateSelectionCell *cell = [[PlateSelectionCell alloc] init];
    
    if (indexPath.section ==  0) {
        if (indexPath.row == 1) {
            cell.label.text = @"分享";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"share" object:cell.label.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        if (indexPath.row == 2) {
            cell.label.text = @"问答";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ask" object:cell.label.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        if (indexPath.row == 3) {
            cell.label.text = @"招聘";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"job" object:cell.label.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        if (indexPath.row == 4) {
            cell.label.text = @"客户端测试";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dev" object:cell.label.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    if (indexPath.section == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}




@end
