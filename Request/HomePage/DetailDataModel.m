//
//  DetailDataModel.m
//  Noder
//
//  Created by 吴志刚 on 22/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "DetailDataModel.h"

@implementation DetailDataModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)repliesJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error ){
        return [MTLJSONAdapter modelsOfClass:[DetailReplies class] fromJSONArray:value error:nil];
    }];

}

@end


@implementation DetailAuthor

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

@end

@implementation DetailReplies

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

//+ (NSValueTransformer *)upsJSONTransformer
//{
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error ){
//        return [MTLJSONAdapter modelsOfClass:[DetailReplies class] fromJSONArray:value error:nil];
//    }];
//}

@end

@implementation RepliesAuthor

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)avatar_urlValueTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end



