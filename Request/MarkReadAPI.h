//
//  MarkReadAPI.h
//  Noder
//
//  Created by 吴志刚 on 12/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <LCNetwork/LCNetwork.h>

@interface MarkReadAPI : LCBaseRequest <LCAPIRequest>

@property (nonatomic, strong) NSString *msg_id;

@end
