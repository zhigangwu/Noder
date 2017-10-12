//
//  Loginapi.h
//  Noder
//
//  Created by alienware on 2017/7/15.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <LCNetwork/LCNetwork.h>


@interface Loginapi : LCBaseRequest<LCAPIRequest>


@property (nonatomic, strong) NSString *loginname;

@end
