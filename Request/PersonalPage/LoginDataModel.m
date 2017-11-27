//
//  LoginDataModel.m
//  Noder
//
//  Created by 吴志刚 on 2017/11/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "LoginDataModel.h"



@implementation LoginDataModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)recent_repliesJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error){
        NSArray *array = [MTLJSONAdapter modelsOfClass:[LoginRecent_replies class] fromJSONArray:value error:nil];
        return array;
    }];
}

+ (NSValueTransformer *)recent_topicsJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error){
        NSArray *array = [MTLJSONAdapter modelsOfClass:[LoginRecent_topics class] fromJSONArray:value error:nil];
        return array;
    }];
}


@end

@implementation LoginRecent_replies

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}


@end

@implementation LoginRecent_topics

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

@end

@implementation Author

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)avatar_urlValueTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end


