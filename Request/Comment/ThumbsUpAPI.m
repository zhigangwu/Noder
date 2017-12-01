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
    return [NSString stringWithFormat:@"api/v1/reply/%@/ups",self.reply_id];

}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodPost;
}

- (id)responseProcess:(id)responseObject
{
    NSDictionary *dictionary = responseObject;
    return [MTLJSONAdapter modelOfClass:[ThumbsDataModel class] fromJSONDictionary:dictionary error:nil];
}

@end
