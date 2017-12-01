//
//  UILabel+LabelHeight.h
//  Noder
//
//  Created by 吴志刚 on 28/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeight)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

@end
