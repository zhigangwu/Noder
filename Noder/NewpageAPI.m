//
//  NewpageAPI.m
//  Noder
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "NewpageAPI.h"

@implementation NewpageAPI

- (NSString *)apiMethodName
{
  return @"api/v1/topics";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodPost;
}

- (LCRequestSerializerType)requestSerializerType{
    return LCRequestSerializerTypeJSON;
}

@end
