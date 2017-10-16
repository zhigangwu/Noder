//
//  ControllerManager.h
//  Noder
//
//  Created by Mac on 2017/9/16.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControllerManager : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSDictionary *dictionary;
@property (nonatomic, copy) NSString *IDString;
@property (nonatomic, copy) NSDictionary *dic;
@property (nonatomic, copy) NSString *reply_ID;

+ (ControllerManager *)shareManager;

@end
