//
//  CollectionAPI.m
//  Noder
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "CollectionAPI.h"
#import "CollectionDataModel.h"

@implementation CollectionAPI

- (NSString *)apiMethodName
{
    return [NSString  stringWithFormat:@"api/v1/topic_collect/%@",self.loginname];
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

- (id)responseProcess:(id)responseObject
{
    NSArray *array = responseObject[@"data"];
    return [MTLJSONAdapter modelsOfClass:[CollectionDataModel class] fromJSONArray:array error:nil];
//    NSDictionary *dictionary = responseObject[@"data"];
//    return [MTLJSONAdapter modelOfClass:[CollectionDataModel class] fromJSONDictionary:dictionary error:nil];
}

@end
