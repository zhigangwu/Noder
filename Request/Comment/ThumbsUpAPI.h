//
//  ThumbsUpAPI.h
//  Noder
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <LCNetwork/LCNetwork.h>
#import "ThumbsDataModel.h"

@interface ThumbsUpAPI : LCBaseRequest <LCAPIRequest>

@property (nonatomic, strong) NSString *reply_id;

@end
