//
//  CollectionDataModel.m
//  Noder
//
//  Created by 吴志刚 on 22/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "CollectionDataModel.h"

@implementation CollectionDataModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

@end


@implementation CollectionAuthor

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)avatar_urlValueTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end

