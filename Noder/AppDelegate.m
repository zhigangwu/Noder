//
//  AppDelegate.m
//  Noder
//
//  Created by alienware on 2017/2/10.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PersonalCenterViewController.h"
#import "Masonry.h"
#import "HomePageController.h"
#import "RecentReplyViewController.h"
#import "RecentTopicsViewController.h"
#import "NewPageTableViewController.h"

#import "ZHTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ZHTabBarController *tabBar = [[ZHTabBarController alloc] init];
    self.window.rootViewController = tabBar;

    
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    self.window.rootViewController = tabBarController;
//
//    PersonalCenterViewController *personalCenterVC = [[PersonalCenterViewController alloc] init];
//    UINavigationController *navpersonal = [[UINavigationController alloc] initWithRootViewController:personalCenterVC];
//    navpersonal.tabBarItem.title = @"我的";
//    [navpersonal.tabBarItem setTag:2];
//    navpersonal.tabBarItem.image = [UIImage imageNamed:@"Rectangle 4"];
//
//    HomePageController *homePageController = [[HomePageController alloc] init];
//    UINavigationController *homeNavigation = [[UINavigationController alloc] initWithRootViewController:homePageController];
//    homeNavigation.tabBarItem.title = @"主页";
//    [homeNavigation.tabBarItem setTag:0];
//    homeNavigation.tabBarItem.image = [UIImage imageNamed:@"Group Copy"];
//
//
//    tabBarController.viewControllers = @[homeNavigation,navpersonal];
    [self.window makeKeyAndVisible];

    
    LCNetworkConfig *config = [LCNetworkConfig sharedInstance];
    config.mainBaseUrl = @"https://cnodejs.org/";
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
