//
//  MarkReadAPI.m
//  Noder
//
//  Created by 吴志刚 on 12/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "MarkReadAPI.h"

@implementation MarkReadAPI

- (NSString *)apiMethodName
{
    return [NSString stringWithFormat:@"api/v1/message/mark_one/%@",self.msg_id];
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodPost;
}

@end
