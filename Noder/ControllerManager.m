//
//  ControllerManager.m
//  Noder
//
//  Created by Mac on 2017/9/16.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ControllerManager.h"

static ControllerManager *manager = nil;

@implementation ControllerManager

+ (ControllerManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ControllerManager alloc] init];
    });
    // 31231232131231312312
    return manager;
}

@end
