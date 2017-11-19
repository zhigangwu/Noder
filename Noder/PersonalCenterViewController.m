//
//  PersonalCenterViewController.m
//  Noder
//
//  Created by alienware on 2017/5/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "ScanLoginCell.h"
#import "RecentReplyViewController.h"
#import "RecentTopicsViewController.h"
#import "CollectionTableViewController.h"
#import "ViewController.h"
#import "QRCodeViewController.h"
#import "NewPageTableViewController.h"
#import "HomePageController.h"
#import "UnreadMessageTableViewController.h"
#import "ReadMessageTableViewController.h"
#import "SetPageViewController.h"

#import "ControllerManager.h"
#import "Masonry.h"

#import "AssesstokenAPI.h"
#import "MessageCountAPI.h"
#import "CollectionAPI.h"
#import "Loginapi.h"
#import "UIColor+background.h"
#import "UIColor+tableBackground.h"



@interface PersonalCenterViewController ()

@property (nonatomic, strong) NSDictionary *success;

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"个人中心";
    
    self.view.backgroundColor = [UIColor backgroundcolor];
    
    _Header = [[headerview alloc] init];
    [self.view addSubview:_Header];
    [_Header mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@110);
    }];
    
    
    UITableView *tableview = [[UITableView alloc] init];
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.Header.mas_bottom).with.offset(4);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(280);
    }];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;//取消系统自带的分割线
    tableview.backgroundColor = [UIColor tableBackground];
    
    tableview.bounces = NO;
    tableview.delegate = self;
    tableview.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [tableview registerClass:[ScanLoginCell class] forCellReuseIdentifier:@"ScanloginCell"];
    
    UIView *bottomview = [UIView new];
    UIImageView *logoImageView = [UIImageView new];
    UILabel *versionlabel = [UILabel new];
    UIView *barView = [UIView new];

    [self.view addSubview:bottomview];
    [bottomview addSubview:logoImageView];
    [bottomview addSubview:versionlabel];
    [self.view addSubview:barView];

    versionlabel.text = @"V 1.0.0";
    versionlabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
    versionlabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1/1.0];
    logoImageView.image = [UIImage imageNamed:@"N"];
    bottomview.backgroundColor = [UIColor backgroundcolor];
    
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(tableview.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(146);
    }];

    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(bottomview);
        make.centerY.mas_equalTo(bottomview);
        make.size.mas_equalTo(CGSizeMake(60, 67));
    }];
    
    [versionlabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(bottomview.mas_bottom).with.offset(-15.7);
        make.centerX.mas_equalTo(bottomview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(40, 18));
    }];
    
    [_Header.button addTarget:self action:@selector(buttonaction) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr = [[NSArray alloc] init];
    arr = @[@"最近回复",@"最近发布",@"我的收藏",@"未读消息",@"已读消息"];
    self.array = arr;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addnotification:)
                                                 name:@"zongzi"
                                               object:nil];

}


- (void)addnotification:(NSNotification *)notification{
    self.QRCodeString = notification.object;
    
    AssesstokenAPI *assAPI = [[AssesstokenAPI alloc] init];

//     必须传入为非空值
    if (self.QRCodeString != nil) {
        assAPI.requestArgument = @{@"accesstoken" : self.QRCodeString};
        
        [assAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
            NSDictionary *dic = request.responseJSONObject;
            [ControllerManager shareManager].dic = dic;
            
            self.dictionary = dic;

            NSString *string = [self.dictionary valueForKey:@"success"];
            if (string.boolValue == 1) {
                NSString *loginname = [self.dictionary valueForKey:@"loginname"];
                self.loginname = loginname;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginname"
                                                                    object:loginname];
                
                CollectionAPI *collAPI = [[CollectionAPI alloc] init];
                collAPI.loginname = loginname;
                
                Loginapi *api = [[Loginapi alloc] init];
                api.loginname = loginname;
                
                [api startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
                    NSDictionary *dic = request.responseJSONObject;
                    
                    [ControllerManager shareManager].dictionary = dic;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzi" object:dic];
                    
                    NSString *success = dic[@"success"];
                    if (success.boolValue == true) {

                        UIButton *rightButton = [[UIButton alloc] init];
                        rightButton.frame = CGRectMake(0, 0, 20, 20);
                        [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                        [rightButton setBackgroundImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
                        [rightButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
                        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
                        self.navigationItem.rightBarButtonItem = rightItem;
                    }
                    [self.Header configWithData:dic];
                    
                } failure:NULL];
                }
            
        } failure:NULL];
    }

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buttonaction{
    QRCodeViewController *QRCode = [[QRCodeViewController alloc] init];
    QRCode.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:QRCode animated:YES];
}

- (void)logout
{
    SetPageViewController *setPage = [[SetPageViewController alloc] init];
    setPage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setPage animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ScanLoginCell *scanlogincell = [tableView dequeueReusableCellWithIdentifier:@"ScanloginCell" forIndexPath:indexPath];
    scanlogincell.textLabel.text = self.array[indexPath.row];
    scanlogincell.imageView.image = [UIImage imageNamed:@"Rectangle 4"];
    scanlogincell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return scanlogincell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RecentReplyViewController *RRViewController = [[RecentReplyViewController alloc] init];
            RRViewController.hidesBottomBarWhenPushed = YES;
            RRViewController.recenrLoginname = self.loginname;
            [self.navigationController pushViewController:RRViewController animated:YES];
        }
        if (indexPath.row == 1) {
            RecentTopicsViewController *RTViewController = [[RecentTopicsViewController alloc] init];
            RTViewController.hidesBottomBarWhenPushed = YES;
            RTViewController.TopicsLoginname = self.loginname;
            [self.navigationController pushViewController:RTViewController animated:YES];
        }
        if (indexPath.row == 2) {
            CollectionTableViewController *collect = [[CollectionTableViewController alloc] init];
            collect.hidesBottomBarWhenPushed = YES;
            collect.collectionLoginname = self.loginname;
            [self.navigationController pushViewController:collect animated:YES];
        }
        if (indexPath.row == 3) {
            UnreadMessageTableViewController *UNMessage = [[UnreadMessageTableViewController alloc] init];
            UNMessage.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:UNMessage animated:YES];
        }
        if (indexPath.row == 4) {
            ReadMessageTableViewController *readMes = [[ReadMessageTableViewController alloc] init];
            readMes.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:readMes animated:YES];
        }
    }
}





@end
