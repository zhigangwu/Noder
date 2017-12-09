//
//  UnreadMessageCell.m
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "UnreadMessageCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+textColor.h"
#import "UIColor+textColorB.h"
#import "NSDate+TimeAgo.h"
#import "UIFont+SetFont.h"

@implementation UnreadMessageCell

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
            make.right.equalTo(self.contentView);
        }];
        
        [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-9.6);
            make.left.equalTo(self.ImageView.mas_right).with.offset(14);
        }];
        
        self.TitleLabel.font = [UIFont ZGFontB];
        self.TitleLabel.textColor = [UIColor textColor];
        
        [self.ImageView.layer setCornerRadius:25.85];
        [self.ImageView.layer setMasksToBounds:YES];
        
        self.durationLabel.font = [UIFont ZGFontC];
        self.durationLabel.textColor = [UIColor textColorB];

    }
    return self;
}

- (void)configWithItem:(Hasnot_read_messages *)hasnot_read
{
    self.TitleLabel.text = hasnot_read.author.loginname;
    [self.imageView sd_setImageWithURL:hasnot_read.author.avatar_url];
    
    NSString *dateStr = hasnot_read.topic.last_reply_at;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    self.durationLabel.text = [date timeAgo];

}


@end
