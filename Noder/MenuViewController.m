//
//  MenuViewController.m
//  Noder
//
//  Created by Mac on 2017/9/21.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "MenuViewController.h"
#import "Masonry.h"
#import "NewPageTableViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *newButton = [[UIButton alloc] init];
    UIButton *unreadMessage = [[UIButton alloc] init];
    UIButton *readMessage = [[UIButton alloc] init];
    UIButton *logoutButton = [[UIButton alloc] init];
    UIButton *dismissButton = [[UIButton alloc] init];

    [self.view addSubview:newButton];
    [self.view addSubview:unreadMessage];
    [self.view addSubview:logoutButton];
    [self.view addSubview:readMessage];
    [self.view addSubview:dismissButton];

    [newButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [unreadMessage setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [readMessage setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];


    [newButton setTitle:@"新建" forState:UIControlStateNormal];
    [unreadMessage setTitle:@"未读消息" forState:UIControlStateNormal];
    [readMessage setTitle:@"已读消息" forState:UIControlStateNormal];
    [logoutButton setTitle:@"退出" forState:UIControlStateNormal];
    [dismissButton setTitle:@"关闭" forState:UIControlStateNormal];

    int podding = 20;
    [newButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).with.offset(podding);
        make.right.equalTo(unreadMessage.mas_left).with.offset(-podding);
        make.height.mas_offset(45);
        make.width.equalTo(unreadMessage);
    }];

    [unreadMessage mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.view);
        make.left.equalTo(newButton.mas_right).with.offset(podding);
        make.right.equalTo(readMessage.mas_left).with.offset(-podding);
        make.height.mas_offset(45);
        make.width.equalTo(readMessage);
    }];

    [readMessage mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.view);
        make.left.equalTo(unreadMessage.mas_right).with.offset(podding);
        make.right.equalTo(logoutButton.mas_left).with.offset(-podding);
        make.height.mas_offset(45);
        make.width.equalTo(logoutButton);
    }];

    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.view);
        make.left.equalTo(readMessage.mas_right).with.offset(podding);
        make.right.equalTo(self.view).with.offset(-podding);
        make.height.mas_offset(45);
        make.width.equalTo(newButton);
    }];
    
    [dismissButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-7);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];

    [newButton setBackgroundColor:[UIColor yellowColor]];
    [unreadMessage setBackgroundColor:[UIColor yellowColor]];
    [readMessage setBackgroundColor:[UIColor yellowColor]];
    [logoutButton setBackgroundColor:[UIColor yellowColor]];
    [dismissButton setBackgroundColor:[UIColor yellowColor]];

    [newButton addTarget:self action:@selector(newPage:) forControlEvents:UIControlEventTouchUpInside];
    [newButton addTarget:self action:@selector(unreadMessage:) forControlEvents:UIControlEventTouchUpInside];
    [newButton addTarget:self action:@selector(readMessage:) forControlEvents:UIControlEventTouchUpInside];
    [newButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [dismissButton addTarget:self action:@selector(closeModeView) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newPage:(UIButton *)sender
{
    NewPageTableViewController *newPage = [[NewPageTableViewController alloc] init];
    UINavigationController *navNewPage = [[UINavigationController alloc] initWithRootViewController:newPage];
    [self presentViewController:navNewPage animated:YES completion:nil];
}

- (void)unreadMessage:(UIButton *)sender
{
    NSLog(@"%@",sender);
}

- (void)readMessage:(UIButton *)sender
{
    NSLog(@"%@",sender);
}

- (void)logout:(UIButton *)sender
{
    NSLog(@"%@",sender);
}

- (void)closeModeView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
