//
//  TabBarController.m
//  Noder
//
//  Created by 吴志刚 on 2017/10/26.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "TabBarController.h"
#import "HomePageController.h"
#import "PersonalCenterViewController.h"

@implementation TabBarController

- (CYLTabBarController *)tabBarController
{
    if (self.tabBarController == nil) {
        CYLTabBarController *tabBar = [[CYLTabBarController alloc] init];
        
        self.tabBarController = tabBar;
    }
    return self.tabBarController;
}

- (void)setupViewControllers
{
    HomePageController *home = [[HomePageController alloc] init];
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:home];
    
    PersonalCenterViewController *personal = [[PersonalCenterViewController alloc] init];
    UINavigationController *navPersonal = [[UINavigationController alloc] initWithRootViewController:personal];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[navHome,navPersonal]];
    
    self.tabBarController = tabBarController;
}

- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController
{
    NSDictionary *view1 = @{
                            CYLTabBarItemTitle : @"主页",
                            CYLTabBarItemImage : @"Group Copy",
                            };
    
    NSDictionary *view2 = @{
                            CYLTabBarItemTitle : @"个人",
                            CYLTabBarItemImage : @"Rectangle 4",
                            };
    
    NSArray *tabBarItemsAttributes = @[view1, view2];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}











@end
