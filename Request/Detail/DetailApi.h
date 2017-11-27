//
//  DetailApi.h
//  Noder
//
//  Created by bawn on 20/06/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <LCNetwork/LCNetwork.h>

@interface DetailApi : LCBaseRequest<LCAPIRequest>

@property (nonatomic, strong) NSString *_id;

@end
