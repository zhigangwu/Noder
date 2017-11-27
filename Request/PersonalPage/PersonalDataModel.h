//
//  PersonalDataModel.h
//  Noder
//
//  Created by 吴志刚 on 2017/11/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PersonalDataModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *loginname;
@property (nonatomic, strong) NSURL *avatar_url;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) BOOL success;

@end
