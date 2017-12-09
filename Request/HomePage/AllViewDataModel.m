//
//  AllViewDataModel.m
//  Noder
//
//  Created by 吴志刚 on 2017/11/19.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "AllViewDataModel.h"

@implementation AllViewDataModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

@end

@implementation ALLAuthor

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)avatar_urlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}



@end
