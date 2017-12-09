//
//  UIFont+SetFont.m
//  Noder
//
//  Created by 吴志刚 on 07/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "UIFont+SetFont.h"

@implementation UIFont (SetFont)

+ (UIFont *)ZGFontA
{
    return [UIFont fontWithName:@".AppleSystemUIFont" size:17];
}

+ (UIFont *)ZGFontB
{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    
}

+ (UIFont *)ZGFontC
{
    return [UIFont fontWithName:@"PingFangSC-Light" size:10];
}

@end
