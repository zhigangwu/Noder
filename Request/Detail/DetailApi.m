//
//  DetailApi.m
//  Noder
//
//  Created by bawn on 20/06/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "DetailApi.h"
#import "DetailDataModel.h"

@implementation DetailApi

// 接口地址
- (NSString *)apiMethodName
{
    return [NSString stringWithFormat:@"api/v1/topic/%@", self._id];
}

// 请求方式
- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

- (id)responseProcess:(id)responseObject
{
    NSDictionary *dictionary = responseObject[@"data"];
    return [MTLJSONAdapter modelOfClass:[DetailDataModel class] fromJSONDictionary:dictionary error:nil];
}

@end
