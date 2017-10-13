//
//  ThumbsUpAPI.m
//  Noder
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ThumbsUpAPI.h"
#import "ControllerManager.h"

@implementation ThumbsUpAPI

- (NSString *)apiMethodName
{

//    return [NSString stringWithFormat:@"api/v1/reply/%@/ups ",self.reply_id];
    return @"api/v1/59deec8b61932717683d228c/ups";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodPost;
}

//- (LCRequestSerializerType)requestSerializerType{
//    return LCRequestSerializerTypeJSON;
//}

@end
