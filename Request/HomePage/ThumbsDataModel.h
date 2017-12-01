//
//  ThumbsDataModel.h
//  Noder
//
//  Created by 吴志刚 on 28/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ThumbsDataModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *action;
@property (nonatomic, assign) BOOL success;

@end
