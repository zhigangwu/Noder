//
//  NETWorkConnection.h
//  Noder
//
//  Created by alienware on 2017/7/10.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NETWorkRequest;

typedef void (^NETWorkConnectionBlock)(NSDictionary *info, NSData *data, NSError *error);

@interface NETWorkConnection : NSObject

@property (nonatomic, strong, readonly) NETWorkRequest *request;

- (instancetype)initWithRequest:(NETWorkRequest *)request;
- (void)resultBlock:(NETWorkConnectionBlock)block;
- (void)start;

@end
