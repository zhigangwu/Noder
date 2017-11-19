//
//  Topic.m
//  Noder
//
//  Created by 吴志刚 on 2017/11/18.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "Topic.h"

@implementation Topic

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

@end


//@implementation Author
//
//+ (NSDictionary *)JSONKeyPathsByPropertyKey{
//    return [NSDictionary mtl_identityPropertyMapWithModel:self];
//}
//
//
//+ (NSValueTransformer *)avatar_urlJSONTransformer{
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}
//@end

