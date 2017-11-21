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
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * authorsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            LoginRecent_replies * recent_replies = [MTLJSONAdapter modelOfClass:[LoginRecent_replies class] fromJSONDictionary:obj error:nil];
            [authorsArray addObject:recent_replies];
        }];
        
        return authorsArray;
    }];
}

+ (NSValueTransformer *)recent_topicsJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * authorsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            LoginRecent_topics * recent_topics = [MTLJSONAdapter modelOfClass:[LoginRecent_topics class] fromJSONDictionary:obj error:nil];
            [authorsArray addObject:recent_topics];
        }];
        
        return authorsArray;
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


