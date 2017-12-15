//
//  UIColor+TitleColor.m
//  Noder
//
//  Created by 吴志刚 on 2017/11/19.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "UIColor+TitleColor.h"

@implementation UIColor (TitleColor)

+ (UIColor *)titleColor
{
    return [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1/1.0];
}

+ (UIColor *)textColor
{
    return [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1/1.0];
}

+ (UIColor *)textColorB
{
    return [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1/1.0];
}

+ (UIColor *)tableBackground
{
    return [UIColor colorWithWhite:215 / 255.0 alpha:0.3];
}

+ (UIColor *)backgroundcolor
{
    return [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1/1.0];
}



@end
