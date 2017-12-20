//
//  NewPageView.m
//  Noder
//
//  Created by 吴志刚 on 09/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "NewPageView.h"
#import "Masonry.h"
#import "UIColor+TitleColor.h"

@implementation NewPageView

- (instancetype)init
{
    if (self = [super init]) {
        self.choseView = [[UIView alloc] init];
        self.choseButton = [[UIButton alloc] init];
        self.choseLabel = [[UILabel alloc] init];
        self.imageview = [[UIImageView alloc] init];
        self.TitleView = [[UITextView alloc] init];
        self.ContentView = [[UITextView alloc] init];
        self.pickLabel = [[UILabel alloc] init];
        UIImageView *imageViewA = [[UIImageView alloc] init];
        UIImageView *imageViewB = [[UIImageView alloc] init];
        [self addSubview:imageViewA];
        [self addSubview:imageViewB];
        [self addSubview:self.choseView];
        [self.choseView addSubview:self.choseButton];
        [self.choseView addSubview:self.choseLabel];
        [self.choseView addSubview:self.imageview];
        [self addSubview:self.TitleView];
        [self addSubview:self.ContentView];
        [self addSubview:self.pickLabel];
        
        [self.TitleView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self);
            make.left.equalTo(self).with.offset(17.5);
            make.right.equalTo(self).with.offset(-18.5);
            make.height.mas_equalTo(58);
        }];
        
        [imageViewA mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.TitleView.mas_bottom);
            make.left.equalTo(self).with.offset(17.5);
            make.right.equalTo(self).with.offset(-18.5);
            make.height.mas_equalTo(3);
        }];
        
        [self.choseView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(imageViewA.mas_bottom);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(44);
        }];
        
        [self.choseButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.choseView);
            make.left.equalTo(self.choseView);
            make.right.equalTo(self.choseView);
            make.bottom.equalTo(self.choseView);
        }];
        
        [self.choseLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.choseView);
            make.left.equalTo(self.choseView).with.offset(17.5);
            make.right.equalTo(self.imageview.mas_left);
            make.height.mas_equalTo(22);
        }];
        
        [self.pickLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.choseView);
            make.left.equalTo(self.choseView).with.offset(17.5);
            make.right.equalTo(self.imageview.mas_left);
            make.height.mas_equalTo(22);
        }];

        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.choseView);
            make.right.equalTo(self.choseView).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(12, 6));
        }];
        
        
        [imageViewB mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.choseView.mas_bottom);
            make.left.equalTo(self).with.offset(17.5);
            make.right.equalTo(self).with.offset(-18.5);
            make.height.mas_equalTo(3);
        }];
        
        [self.ContentView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(imageViewB.mas_bottom);
            make.left.equalTo(self).with.offset(17.5);
            make.right.equalTo(self).with.offset(-18.5);
            make.bottom.equalTo(self);
        }];
        
        [self.TitleView setTextAlignment:NSTextAlignmentLeft];
        self.TitleView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.TitleView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
        self.TitleView.textColor = [UIColor titleColor];
        self.TitleView.text = @"输入标题";
        
        imageViewA.contentMode = UIViewContentModeScaleAspectFit;
        imageViewB.contentMode = UIViewContentModeScaleAspectFit;
        imageViewA.image = [UIImage imageNamed:@"Line@2x"];
        imageViewB.image = [UIImage imageNamed:@"Line@2x"];
        
        self.choseLabel.text = @"选择板块";
        self.choseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        self.choseLabel.textColor = [UIColor titleColor];
        
        self.imageview.image = [UIImage imageNamed:@"Rectangle 2"];
        
        self.TitleView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _ContentView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.ContentView.textColor = [UIColor titleColor];
        self.ContentView.text = @"输入内容";
    }
    return self;
}
@end
