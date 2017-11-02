//
//  TabBarController.h
//  Noder
//
//  Created by 吴志刚 on 2017/10/26.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"

@interface TabBarController : NSObject

@property (nonatomic, strong) CYLTabBarController *tabBarController;

- (void)setupViewControllers;

@end
