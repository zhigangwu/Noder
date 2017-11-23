//
//  MessageAPI.m
//  Noder
//
//  Created by 吴志刚 on 22/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "MessageAPI.h"
#import "MessageDataModel.h"

@implementation MessageAPI

- (NSString *)apiMethodName
{
    return @"api/v1/messages";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

- (LCRequestSerializerType)requestSerializerType
{
    return LCRequestSerializerTypeJSON;
}

- (id)responseProcess:(id)responseObject
{
    NSDictionary *dictionary= responseObject[@"data"];
    return [MTLJSONAdapter modelOfClass:[MessageDataModel class] fromJSONDictionary:dictionary error:nil];
}


@end
