//
//  CollectionAPI.m
//  Noder
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "CollectionAPI.h"

@implementation CollectionAPI

- (NSString *)apiMethodName
{
    return [NSString  stringWithFormat:@"api/v1/topic_collect/%@",self.loginname];
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

@end
