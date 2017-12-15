//
//  RecentReplyCell.m
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "RecentReplyCell.h"
#import "Masonry.h"
#import "UIColor+TitleColor.h"
#import "NSDate+TimeAgo.h"
#import "UIFont+SetFont.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation RecentReplyCell

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
            make.size.mas_equalTo(CGSizeMake(52, 52));
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

        CALayer *layer = [self.ImageView layer];
        [layer setMasksToBounds:YES];
        [layer setShadowOpacity:0];
        [layer setCornerRadius:26];
        [layer setBorderWidth:0.5];
        [layer setBorderColor:[[UIColor grayColor] CGColor]];

        
        self.durationLabel.font = [UIFont ZGFontC];
        self.durationLabel.textColor = [UIColor textColorB];

    }
    return self;
}

- (void)configWithItem:(LoginRecent_replies *)recent_replies
{
    self.TitleLabel.text = recent_replies.title;
    [self.ImageView sd_setImageWithURL:recent_replies.author.avatar_url];
    
    NSString *dateStr = recent_replies.last_reply_at;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    self.durationLabel.text = [date timeAgo];
    
}










@end
