//
//  Loginapi.m
//  Noder
//
//  Created by alienware on 2017/7/15.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "Loginapi.h"
#import "LoginDataModel.h"

@implementation Loginapi

// 接口地址
- (NSString *)apiMethodName
{

    return [NSString stringWithFormat:@"api/v1/user/%@", self.loginname];

}

// 请求方式
- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

- (id)responseProcess:(id)responseObject
{
    NSDictionary *dictionary= responseObject[@"data"];
    return [MTLJSONAdapter modelOfClass:[LoginDataModel class] fromJSONDictionary:dictionary error:nil];
}

















@end
