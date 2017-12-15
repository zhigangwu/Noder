//
//  headerview.m
//  Noder
//
//  Created by alienware on 2017/7/15.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "headerview.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ControllerManager.h"
#import "UIColor+TitleColor.h"

@interface headerview ()

@property (nonatomic, strong) UIImageView *avatarImageView;


@end

@implementation headerview

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.imageview = [[UIImageView alloc] init];
        [self addSubview:_imageview];
        [_imageview mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self);
            make.right.equalTo(self).with.offset(-16);
            make.size.mas_equalTo(CGSizeMake(8, 13));
        }];
        _imageview.image = [UIImage imageNamed:@"Disclosure Indicator"];
        
        self.titleLabel = [[UILabel alloc] init];
        
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(40);
            make.left.equalTo(self).with.offset(10);
        }];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setText:@"扫码登入"];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:24];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@110);
        }];
        
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(110);
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.top.equalTo(self);
        }];
        
        
        UIImageView *avatarImageView = [[UIImageView alloc] init];
        [self addSubview:avatarImageView];
        [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(78, 78));
            make.leading.equalTo(@16);
            make.top.equalTo(@16);
        }];
        avatarImageView.hidden = YES;
        self.avatarImageView = avatarImageView;
        
        UILabel *name = [[UILabel alloc] init];
        [self addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(25);
            make.left.equalTo(avatarImageView.mas_right).with.offset(20);
        }];
        self.nameLabel = name;
        self.button = button;
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        self.nameLabel.textColor = [UIColor textColor];
        
        CALayer *layer = [avatarImageView layer];
        [layer setMasksToBounds:YES];
        [layer setShadowOpacity:0];
        [layer setCornerRadius:39];
        [layer setBorderWidth:0.5];
        [layer setBorderColor:[[UIColor grayColor] CGColor]];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(addnotification:)
//                                                     name:@"tongzi"
//                                                   object:nil];
        
    }
    return self;
}

//- (void)addnotification:(NSNotification *)notification
//{
////    NSDictionary *dictionary = notification.object;
////    NSString *dataString = dictionary[@"success"];
////    NSLog(@"dataString = %@", dataString);
//    if (dataString.boolValue == true) {
//        self.titleLabel.hidden = YES;
//        self.imageview.hidden = YES;
//    } else {
//        self.titleLabel.hidden = NO;
//    }
//}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)configWithData:(PersonalDataModel *)personalModel{
    
    [self.avatarImageView sd_setImageWithURL:personalModel.avatar_url];
    self.nameLabel.text = personalModel.loginname;
    
    self.button.hidden = YES;
    self.avatarImageView.hidden = NO;
    
    if (personalModel.success == true) {
        self.titleLabel.hidden = YES;
        self.imageview.hidden = YES;
    } else {
        self.titleLabel.hidden = NO;
    }

}



@end
