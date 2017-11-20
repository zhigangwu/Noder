//
//  EssenceAPI.m
//  Noder
//
//  Created by alienware on 2017/8/24.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "EssenceAPI.h"
#import "EssenceDataModel.h"

@implementation EssenceAPI

- (NSString *)apiMethodName{
    return @"api/v1/topics?tab=good";
}

- (LCRequestMethod)requestMethod{
    return LCRequestMethodGet;
}

- (id)responseProcess:(id)responseObject
{
    NSArray *array = responseObject[@"data"];
    return [MTLJSONAdapter modelsOfClass:[EssenceDataModel class] fromJSONArray:array error:nil];
}

@end
