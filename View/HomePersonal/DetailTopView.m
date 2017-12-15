//
//  DetailTopView.m
//  Noder
//
//  Created by 吴志刚 on 03/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "DetailTopView.h"
#import "Masonry.h"
#import "UIColor+TitleColor.h"
#import "UIFont+SetFont.h"

@implementation DetailTopView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CALayer *viewlayer = [self layer];
        [viewlayer setShadowOpacity:0];
        [viewlayer setBorderWidth:0.5];
        [viewlayer setBorderColor:[ [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1/1.0] CGColor]];

        self.imageview = [[UIImageView alloc] init];
        self.loginnameLabel = [[UILabel alloc] init];
        self.postedLabel = [[UILabel alloc] init];// 发表时间
        UIImageView *eyeImageView = [[UIImageView alloc] init];
        UIImageView *messageIamgeView = [[UIImageView alloc] init];
        self.watchLabel = [[UILabel alloc] init];
        self.messageLabel = [[UILabel alloc] init];
        
        [self addSubview:self.imageview];
        [self addSubview:self.loginnameLabel];
        [self addSubview:self.postedLabel];
        
        [self addSubview:eyeImageView];
        [self addSubview:messageIamgeView];
        [self addSubview:self.watchLabel];
        [self addSubview:self.messageLabel];
        
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(13);
            make.left.equalTo(self).with.offset(16);
            make.size.mas_equalTo(CGSizeMake(48, 48));
        }];
        
        [self.loginnameLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(11);
            make.left.equalTo(self.imageview.mas_right).with.offset(8.5);
            make.height.mas_equalTo(25);
        }];
        
        [self.postedLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.loginnameLabel.mas_bottom).with.offset(11);
            make.left.equalTo(self.imageview.mas_right).with.offset(9);
            make.height.mas_equalTo(14);
        }];
        
        [eyeImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self).with.offset(-14.2);
            make.right.equalTo(messageIamgeView.mas_left).with.offset(-41.1);
            make.size.mas_equalTo(CGSizeMake(15, 8));
        }];
        
        [self.watchLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self).with.offset(-11.4);
            make.right.equalTo(messageIamgeView.mas_left).with.offset(-8.1);
            make.height.mas_equalTo(14);
        }];
        
        [messageIamgeView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self).with.offset(-13);
            make.right.equalTo(self).with.offset(-38.9);
            make.size.mas_equalTo(CGSizeMake(12, 10));
        }];
        
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self).with.offset(-11.4);
            make.right.equalTo(self).with.offset(-17);
            make.height.mas_equalTo(14);
        }];
        
        CALayer *layer = [self.imageview layer];
        [layer setMasksToBounds:YES];
        [layer setShadowOpacity:0];
        [layer setCornerRadius:24];
        [layer setBorderWidth:0.5];
        [layer setBorderColor:[[UIColor grayColor] CGColor]];
        
        self.loginnameLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        self.loginnameLabel.textColor = [UIColor textColor];
        
        self.postedLabel.font = [UIFont ZGFontC];
        self.postedLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1/1.0];
        
        self.watchLabel.font = [UIFont ZGFontC];
        self.watchLabel.textColor = [UIColor textColorB];
        
        self.messageLabel.font = [UIFont ZGFontC];
        self.messageLabel.textColor = [UIColor textColorB];
        
        eyeImageView.image = [UIImage imageNamed:@"Group-1"];
        messageIamgeView.image = [UIImage imageNamed:@"message"];
        
    }
    return self;
}

@end
