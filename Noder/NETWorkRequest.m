//
//  NETWorkRequest.m
//  Noder
//
//  Created by alienware on 2017/7/10.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "NETWorkRequest.h"

@implementation NETWorkRequest

- (instancetype)init{
    self = [super init];
    if (self) {
        _request = [NSMutableURLRequest new];
    }
    return self;
}

- (void)configRequest:(NETWorkRequestBlock)block{
    block(self.request);
}

@end
