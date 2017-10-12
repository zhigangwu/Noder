//
//  EssenceAPI.m
//  Noder
//
//  Created by alienware on 2017/8/24.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "EssenceAPI.h"

@implementation EssenceAPI

- (NSString *)apiMethodName{
    return @"api/v1/topics?tab=good";
}

- (LCRequestMethod)requestMethod{
    return LCRequestMethodGet;
}

@end
