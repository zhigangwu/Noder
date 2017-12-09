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
#import "UIFont+SetFont.h"


@implementation PersonalCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"个人中心";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName: [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
    self.view.backgroundColor = [UIColor backgroundcolor];
    
    _Header = [[headerview alloc] init];
    [self.view addSubview:_Header];
    [_Header mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@110);
    }];
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.Header.mas_bottom).with.offset(4);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(292);
    }];
    
    //    cell分割线全屏
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }

    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[ScanLoginCell class] forCellReuseIdentifier:@"ScanloginCell"];
    
//    UIView *bottomview = [UIView new];
//    UIImageView *logoImageView = [UIImageView new];
//    UILabel *versionlabel = [UILabel new];
//    UIView *barView = [UIView new];
//
//    [self.view addSubview:bottomview];
//    [bottomview addSubview:logoImageView];
//    [bottomview addSubview:versionlabel];
//    [self.view addSubview:barView];
//
//    versionlabel.text = @"V 1.0.0";
//    versionlabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
//    versionlabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1/1.0];
//    logoImageView.image = [UIImage imageNamed:@"N"];
//    bottomview.backgroundColor = [UIColor backgroundcolor];
//
//    [bottomview mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.equalTo(self.tableView.mas_bottom);
//        make.left.and.right.equalTo(self.view);
//        make.height.mas_equalTo(146);
//    }];
//
//    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.centerX.mas_equalTo(bottomview);
//        make.centerY.mas_equalTo(bottomview);
//        make.size.mas_equalTo(CGSizeMake(60, 67));
//    }];
//
//    [versionlabel mas_makeConstraints:^(MASConstraintMaker *make){
//        make.bottom.equalTo(bottomview.mas_bottom).with.offset(-15.7);
//        make.centerX.mas_equalTo(bottomview.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(40, 18));
//    }];
    
    [_Header.button addTarget:self action:@selector(buttonaction) forControlEvents:UIControlEventTouchUpInside];
    
    PersonalTableModle *personal = [[PersonalTableModle alloc] initWithNSArray];
    self.array = personal.array;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addnotification:)
                                                 name:@"zongzi"
                                               object:nil];
    

    
}

- (void)addnotification:(NSNotification *)notification
{
    NSString *QRCodeString = [ControllerManager shareManager].string;
    
    if (QRCodeString != nil) {
        AssesstokenAPI *assAPI = [[AssesstokenAPI alloc] init];
        assAPI.requestArgument = @{@"accesstoken" : QRCodeString};
        [assAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
            self.personalModel = request.responseJSONObject;
            
            [ControllerManager shareManager].id = self.personalModel.id;
            [ControllerManager shareManager].success = self.personalModel.success;
            [ControllerManager shareManager].URLImage = self.personalModel.avatar_url;
            
            if (self.personalModel.success == 1) {
                
                CollectionAPI *collAPI = [[CollectionAPI alloc] init];
                collAPI.loginname = self.personalModel.loginname;
                
                Loginapi *api = [[Loginapi alloc] init];
                api.loginname = self.personalModel.loginname;
                
                [self.Header configWithData:self.personalModel];

                UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"set"]
                                                                                       style:UIBarButtonItemStyleDone
                                                                                      target:self
                                                                                      action:@selector(logout)];
                self.navigationItem.rightBarButtonItem = rightBarButton;
                
            }
        } failure:nil];
        
        MessageAPI *messAPI = [[MessageAPI alloc] init];
        messAPI.requestArgument = @{@"accesstoken" : QRCodeString};
        [messAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
                
            self.messageModel  = request.responseJSONObject;
            self.messageArray = self.messageModel.has_read_messages;

            [self.tableView reloadData];
        } failure:NULL];

    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buttonaction
{
    QRCodeViewController *QRCode = [[QRCodeViewController alloc] init];
    QRCode.hidesBottomBarWhenPushed = YES;// 隐藏tabbar
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
    scanlogincell.selectionStyle = UITableViewCellSelectionStyleNone;
    scanlogincell.textLabel.text = self.array[indexPath.row];
    scanlogincell.messageLabel.hidden = YES;
    
    if (self.personalModel.success == 1) {
        if (indexPath.row == 3) {
            scanlogincell.messageLabel.hidden = NO;
            scanlogincell.messageLabel.text = [NSString stringWithFormat:@"%ld",self.messageModel.hasnot_read_messages.count];
        }
        if (indexPath.row == 4) {
            scanlogincell.messageLabel.hidden = NO;
            scanlogincell.messageLabel.text = [NSString stringWithFormat:@"%ld",self.messageModel.has_read_messages.count];
        }
    }
    
    scanlogincell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    分割线全屏
    if ([scanlogincell respondsToSelector:@selector(setLayoutMargins:)]) {
        [scanlogincell setLayoutMargins:UIEdgeInsetsZero];
    }

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
    return 12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.personalModel.success == 1) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                RecentReplyViewController *RRViewController = [[RecentReplyViewController alloc] init];
                RRViewController.hidesBottomBarWhenPushed = YES;
                RRViewController.recenrLoginname = self.personalModel.loginname;
                [self.navigationController pushViewController:RRViewController animated:YES];
            }
            if (indexPath.row == 1) {
                RecentTopicsViewController *RTViewController = [[RecentTopicsViewController alloc] init];
                RTViewController.hidesBottomBarWhenPushed = YES;
                RTViewController.TopicsLoginname = self.personalModel.loginname;
                [self.navigationController pushViewController:RTViewController animated:YES];
            }
            if (indexPath.row == 2) {
                CollectionTableViewController *collect = [[CollectionTableViewController alloc] init];
                collect.hidesBottomBarWhenPushed = YES;
                collect.collectionLoginname = self.personalModel.loginname;
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
}





@end
