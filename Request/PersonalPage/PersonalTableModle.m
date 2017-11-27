//
//  PersonalTableModle.m
//  Noder
//
//  Created by 吴志刚 on 25/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "PersonalTableModle.h"
#import "ControllerManager.h"

@implementation PersonalTableModle

- (instancetype)initWithNSArray
{
    if (self = [super init]) {
        self.array = [[NSArray alloc] initWithObjects:@"最近回复",@"最近发布",@"我的收藏",@"未读消息",@"已读消息", nil];
            
    }
    return self;
}



@end
