//
//  comContentAPI.m
//  Noder
//
//  Created by Mac on 2017/9/15.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "comContentAPI.h"

@implementation comContentAPI

- (NSString *)apiMethodName
{
    NSLog(@"^^^^^^%@",_topic_id);
    return [NSString stringWithFormat:@"api/v1/topic/%@/replies",self.topic_id];
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodPost;
}

- (LCRequestSerializerType)requestSerializerType{
    return LCRequestSerializerTypeJSON;
}

@end
