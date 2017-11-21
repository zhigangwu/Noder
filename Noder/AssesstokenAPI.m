//
//  AssesstokenAPI.m
//  Noder
//
//  Created by alienware on 2017/7/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "AssesstokenAPI.h"
#import "PersonalDataModel.h"

@implementation AssesstokenAPI

// 接口地址
- (NSString *)apiMethodName
{
    return @"api/v1/accesstoken";
}

// 请求方式
- (LCRequestMethod)requestMethod
{
    return LCRequestMethodPost;
}


- (LCRequestSerializerType)requestSerializerType
{
    return LCRequestSerializerTypeJSON;
}

- (id)responseProcess:(id)responseObject
{
//    return responseObject;
    return [MTLJSONAdapter modelOfClass:[PersonalDataModel class] fromJSONDictionary:responseObject error:nil];
}




@end
