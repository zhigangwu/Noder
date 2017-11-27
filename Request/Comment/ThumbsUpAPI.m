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
    NSLog(@"reply_id = %@",self.reply_id);
    return [NSString stringWithFormat:@"api/v1/reply/%@/ups",self.reply_id];

}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodPost;
}

@end
