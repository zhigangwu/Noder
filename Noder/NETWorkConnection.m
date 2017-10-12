//
//  NETWorkConnection.m
//  Noder
//
//  Created by alienware on 2017/7/10.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "NETWorkConnection.h"
#import "NETWorkRequest.h"

@interface NETWorkConnection () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, copy)   NETWorkConnectionBlock  onncetionBlock;   // 网络连接用block
@property (nonatomic, assign) unsigned long long      expectedLength;   // 从服务器获取期望文件的大小

@property (nonatomic, strong) NSURLConnection        *conncetion;       // 网络连接
@property (nonatomic, strong) NSMutableData          *cacheData;        // 用于缓存的data数据
@property (nonatomic, strong) NSURLResponse          *response;         // 回复
@property (nonatomic, strong) NSMutableDictionary    *info;             // 一些链接的信息


@end

@implementation NETWorkConnection

- (instancetype)initWithRequest:(NETWorkRequest *)request{
    self = [super init];
    if (self) {

    _conncetion = [[NSURLConnection alloc] initWithRequest:request.request
                                                  delegate:self
                                          startImmediately:NO];
    
    _cacheData = [NSMutableData data];
    
    _info = [NSMutableDictionary new];
    }
    
    return self;
}

- (void)start {
    [self.conncetion start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_info setObject:@(response.expectedContentLength) forKey:@"expectedContentLength"];
    if (response.suggestedFilename)
        [_info setObject:response.suggestedFilename forKey:@"suggestedFilename"];
    if (response.MIMEType)
        [_info setObject:response.MIMEType          forKey:@"MIMEType"];
    if (response.textEncodingName)
        [_info setObject:response.textEncodingName  forKey:@"textEncodingName"];
    if (response.URL.description)
        [_info setObject:response.URL.description   forKey:@"URL"];
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
        
        _response =  response;
        
        [_info setObject:r.allHeaderFields forKey:@"allHeaderFields"];
        [_info setObject:@(r.statusCode) forKey:@"statusCode"];
        
        if ([r expectedContentLength] != NSURLResponseUnknownLength) {
            _expectedLength = [r expectedContentLength];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    // 存储缓存数据
    [_cacheData appendData:theData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 如果存在block则执行
    if (_onncetionBlock)
    {
        // 调用block
        _onncetionBlock(_info, _cacheData, nil);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // 如果存在block则执行
    if (_onncetionBlock)
    {
        // 调用block
        _onncetionBlock(_info, nil, error);
    }
}

- (void)resultBlock:(NETWorkConnectionBlock)block
{
    // 防止循环引用
    __weak NSMutableDictionary *infoDic = _info;
    
    // 初始化block
    _onncetionBlock = ^(NSDictionary *info, NSData *data, NSError *error)
    {
        // 调用block
        block(infoDic, data, error);
    };
}

- (void)dealloc
{
    /* After this method is called, the connection’s delegate no longer
     receives any messages for the connection. If you want to reattempt
     the connection, you should create a new connection object. */
    [_conncetion cancel];
}


























@end
