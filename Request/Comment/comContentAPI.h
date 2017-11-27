//
//  comContentAPI.h
//  Noder
//
//  Created by Mac on 2017/9/15.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <LCNetwork/LCNetwork.h>

@interface comContentAPI : LCBaseRequest <LCAPIRequest>

@property (nonatomic, strong) NSString *topic_id;

@end
