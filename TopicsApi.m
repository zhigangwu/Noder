//
//  TopicsApi.m
//  Noder
//
//  Created by alienware on 2017/2/12.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "TopicsApi.h"

@implementation TopicsApi

// 接口地址
- (NSString *)apiMethodName
{
  return @"api/v1/topics";
}

// 请求方式
- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}



@end
