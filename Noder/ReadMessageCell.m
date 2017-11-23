//
//  ReadMessageCell.m
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ReadMessageCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+textColor.h"
#import "NSDate+TimeAgo.h"
#import "UIColor+textColorB.h"
#import "NSDate+TimeAgo.h"


@implementation ReadMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.TitleLabel = [[UILabel alloc] init];
        self.durationLabel = [[UILabel alloc] init];
        self.ImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.ImageView];
        [self.contentView addSubview:self.TitleLabel];
        [self.contentView addSubview:self.durationLabel];
        
        [self.ImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).with.offset(15.9);
            make.size.mas_equalTo(CGSizeMake(52, 51.7));
        }];
        
        [self.TitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView).with.offset(11.6);
            make.left.equalTo(self.ImageView.mas_right).with.offset(11);
        }];
        
        [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-9.6);
            make.left.equalTo(self.ImageView.mas_right).with.offset(14);
        }];
        
        self.TitleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        self.TitleLabel.textColor = [UIColor textColor];
        
        [self.ImageView.layer setCornerRadius:25.85];
        [self.ImageView.layer setMasksToBounds:YES];
        
        self.durationLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        self.durationLabel.textColor = [UIColor textColorB];

    }
    return self;
}

- (void)configWithItem:(Has_read_messages *)has_read_messages
{
    self.TitleLabel.text = has_read_messages.topic.title;
    [self.ImageView sd_setImageWithURL:has_read_messages.author.avatar_url];
    
    NSString *dateStr = has_read_messages.topic.last_reply_at;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    self.durationLabel.text = [date timeAgo];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
