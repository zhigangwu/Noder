//
//  RecruitmentTableViewCell.m
//  Noder
//
//  Created by alienware on 2017/6/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "RecruitmentTableViewCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+TimeAgo.h"
#import "UIColor+textColor.h"
#import "UIColor+textColorB.h"

@implementation RecruitmentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.image_view = [[UIImageView alloc] init];
        self.topImage = [[UIImageView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.durationLabel = [[UILabel alloc] init];
        self.eyeImageView = [[UIImageView alloc] init];
        self.messageIamgeView = [[UIImageView alloc] init];
        self.watchLabel = [[UILabel alloc] init];
        self.messageLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:self.image_view];
        [self.contentView addSubview:self.topImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.durationLabel];
        [self.contentView addSubview:self.eyeImageView];
        [self.contentView addSubview:self.messageIamgeView];
        [self.contentView addSubview:self.watchLabel];
        [self.contentView addSubview:self.messageLabel];
        
        [self.image_view mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).with.offset(15.9);
            make.top.equalTo(self.contentView).with.offset(11.4);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.topImage mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.contentView).with.offset(-16);
            make.top.equalTo(self.contentView).with.offset(15.3);
            make.size.mas_equalTo(CGSizeMake(12, 13));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.image_view.mas_right).with.offset(11);
            make.top.equalTo(self.contentView).with.offset(11.4);
            make.right.equalTo(self.topImage.mas_right).with.offset(-20);
        }];
        
        [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-9.6);
            make.left.equalTo(self.image_view.mas_right).with.offset(14);
        }];
        
        [self.eyeImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-13);
            make.right.equalTo(self.watchLabel.mas_left).with.offset(-4);
            make.size.mas_equalTo(CGSizeMake(15, 8));
        }];
        
        [self.watchLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-11.7);
            make.right.equalTo(self.messageIamgeView.mas_left).with.offset(-10.1);
        }];
        
        [self.messageIamgeView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-11.7);
            make.right.equalTo(self.messageLabel.mas_left).with.offset(-3.9);
            make.size.mas_equalTo(CGSizeMake(12, 10));
        }];
        
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-10.1);
            make.right.equalTo(self.contentView).with.offset(-16);
            //            make.size.mas_equalTo(CGSizeMake(18, 14));
        }];
        
        [self.image_view.layer setCornerRadius:20];
        [self.image_view.layer setMasksToBounds:YES];
        
        
        [self.titleLabel setNumberOfLines:0];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        self.titleLabel.textColor = [UIColor textColor];
        
        self.durationLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        self.durationLabel.textColor = [UIColor textColorB];
        
        self.watchLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        self.watchLabel.textColor = [UIColor textColorB];
        
        self.messageLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        self.messageLabel.textColor = [UIColor textColorB];

    }
    
    return self;
}

- (void)configWithItem:(JobDataModel *)jobModel{

    self.titleLabel.text = jobModel.title;
    self.titleLabel.numberOfLines = 1;
//    self.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize max = CGSizeMake(200, 20);
    CGSize expect = [self.titleLabel sizeThatFits:max];
    self.titleLabel.frame = CGRectMake(79, 12, expect.width, expect.height);
    
    [self.image_view sd_setImageWithURL:jobModel.author.avatar_url];
    
    
    NSString *dateStr = jobModel.last_reply_at;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    self.durationLabel.text = [date timeAgo];
    
    // eye message 图标
    self.eyeImageView.image = [UIImage imageNamed:@"Group-1.png"];
    self.messageIamgeView.image = [UIImage imageNamed:@"message.png"];

    self.watchLabel.adjustsFontSizeToFitWidth = YES;
    self.watchLabel.text = [NSString stringWithFormat:@"%@",jobModel.visit_count];
    self.messageLabel.text = [NSString stringWithFormat:@"%@",jobModel.reply_count];
}
@end
