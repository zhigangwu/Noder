//
//  ZHTabBarController.m
//  Noder
//
//  Created by Mac on 2017/9/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ZHTabBarController.h"
#import "PersonalCenterViewController.h"
#import "HomePageController.h"
#import "AddTabBar.h"
#import "NewPageTableViewController.h"
#import "ControllerManager.h"

@interface ZHTabBarController ()

@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewController];
    
    AddTabBar *addTaBbar = [[AddTabBar alloc] initWithFrame:self.tabBar.frame];
    
    [self setValue:addTaBbar forKeyPath:@"tabBar"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuButton)
                                                 name:@"AddTabBarClick"
                                               object:nil];
}

- (void)setupChildViewController
{
    HomePageController *homePage = [[HomePageController alloc] init];
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:homePage];
    navHome.tabBarItem.title = @"主页";
    navHome.tabBarItem.image = [UIImage imageNamed:@"Group Copy"];
    
    PersonalCenterViewController *personal = [[PersonalCenterViewController alloc] init];
    UINavigationController *navPersonal = [[UINavigationController alloc] initWithRootViewController:personal];
    navPersonal.tabBarItem.title = @"我的";
    navPersonal.tabBarItem.image = [UIImage imageNamed:@"Rectangle 4"];;
    
    self.viewControllers = @[navHome,navPersonal];
}

- (void)menuButton
{
    NSDictionary *dic = [ControllerManager shareManager].dictionary;
    NSString *success = dic[@"success"];
    
    if (success.boolValue == true) {
        NewPageTableViewController *newPage = [[NewPageTableViewController alloc] init];
        UINavigationController *navNewPage = [[UINavigationController alloc] initWithRootViewController:newPage];
        [self presentViewController:navNewPage animated:YES completion:nil];
    } else {
        NSLog(@"请登入");
    }

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
