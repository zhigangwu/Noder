//
//  ShareDataModel.m
//  Noder
//
//  Created by 吴志刚 on 2017/11/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ShareDataModel.h"

@implementation ShareDataModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

@end

@implementation ShareAuthor

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)avatar_urlValueTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end

