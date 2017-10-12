//
//  NETWorkRequest.h
//  Noder
//
//  Created by alienware on 2017/7/10.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>

// block的相关定义
typedef void (^NETWorkRequestBlock)(NSMutableURLRequest *request);

@interface NETWorkRequest : NSObject

@property (nonatomic, strong, readonly) NSMutableURLRequest *request;

- (void)configRequest:(NETWorkRequestBlock)block; // 配置请求

@end
