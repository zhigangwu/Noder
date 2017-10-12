//
//  CollectionAPI.h
//  Noder
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <LCNetwork/LCNetwork.h>

@interface CollectionAPI : LCBaseRequest <LCAPIRequest>

@property (nonatomic, strong) NSString *loginname;

@end
