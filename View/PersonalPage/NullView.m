//
//  NullView.m
//  Noder
//
//  Created by 吴志刚 on 05/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "NullView.h"
#import "Masonry.h"
#import "UIColor+TitleColor.h"

@implementation NullView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        UIImageView *imageview = [[UIImageView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        
        [self addSubview:imageview];
        [self addSubview:label];
        
        [imageview mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(190, 190));
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(imageview.mas_bottom).with.offset(12);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(20);
        }];
        
        imageview.image = [UIImage imageNamed:@"copy 6@3x"];
        label.text = @"暂时还没有消息";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        label.textColor = [UIColor textColor];
    }
    return self;
}

@end
