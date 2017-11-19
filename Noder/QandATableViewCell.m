//
//  QandATableViewCell.m
//  Noder
//
//  Created by alienware on 2017/6/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "QandATableViewCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+TimeAgo.h"
#import "UIColor+textColor.h"
#import "UIColor+textColorB.h"

@implementation QandATableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageView = [UIImageView new];
        UILabel *titleLabel = [UILabel new];
        UILabel *durationLabel = [UILabel new];
        UIImageView *eyeImageView = [UIImageView new];
        UIImageView *messageIamgeView = [UIImageView new];
        UILabel *watchLabel = [UILabel new];
        UILabel *messageLabel = [UILabel new];
        
        [self.contentView addSubview:imageView];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:durationLabel];
        [self.contentView addSubview:eyeImageView];
        [self.contentView addSubview:messageIamgeView];
        [self.contentView addSubview:watchLabel];
        [self.contentView addSubview:messageLabel];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).with.offset(15.9);
            make.top.equalTo(self.contentView).with.offset(11.4);
            make.size.mas_equalTo(CGSizeMake(52, 51.7));
        }];
        self.imageVIew = imageView;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(11);
            make.top.equalTo(self.contentView).with.offset(11.4);
        }];
        self.titleLabel = titleLabel;
        
        [durationLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-9.6);
            make.left.equalTo(imageView.mas_right).with.offset(14);
        }];
        self.durationLabel = durationLabel;
        
        [eyeImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-13);
            make.right.equalTo(watchLabel.mas_left).with.offset(-4);
            make.size.mas_equalTo(CGSizeMake(15, 8));
        }];
        self.eyeImageView = eyeImageView;
        
        [watchLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-11.7);
            make.right.equalTo(messageIamgeView.mas_left).with.offset(-10.1);
            //            make.size.mas_equalTo(CGSizeMake(24, 14));
        }];
        self.watchLabel = watchLabel;
        
        [messageIamgeView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-11.7);
            make.right.equalTo(messageLabel.mas_left).with.offset(-3.9);
            make.size.mas_equalTo(CGSizeMake(12, 10));
        }];
        self.messageIamgeView = messageIamgeView;
        
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-10.1);
            make.right.equalTo(self.contentView).with.offset(-16);
            //            make.size.mas_equalTo(CGSizeMake(18, 14));
        }];
        self.messageLabel = messageLabel;
        
        [imageView.layer setCornerRadius:25.85];
        [imageView.layer setMasksToBounds:YES];
        
        [titleLabel setNumberOfLines:0];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        titleLabel.textColor = [UIColor textColor];
        
        durationLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        durationLabel.textColor = [UIColor textColorB];
        
        watchLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        watchLabel.textColor = [UIColor textColorB];
        
        messageLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        messageLabel.textColor = [UIColor textColorB];
        
        
        
    }
    
    return self;
}

- (void)configWithItem:(NSDictionary *)dictionary{
    
    
    self.titleLabel.text = [dictionary objectForKey:@"title"];
    self.titleLabel.numberOfLines = 1;
//    self.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize max = CGSizeMake(200, 20);
    CGSize expect = [self.titleLabel sizeThatFits:max];
    self.titleLabel.frame = CGRectMake(79, 12, expect.width, expect.height);
    
    [self.imageVIew sd_setImageWithURL:dictionary[@"author"][@"avatar_url"]];
    
    
    NSString *dateStr = dictionary[@"last_reply_at"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    self.durationLabel.text = [date timeAgo];
    
    // eye message 图标
    self.eyeImageView.image = [UIImage imageNamed:@"Group-1.png"];
    self.messageIamgeView.image = [UIImage imageNamed:@"message.png"];
    
    // watchLabel
    NSNumber *visit_count = [dictionary objectForKey:@"visit_count"];
    NSNumber *reply_count = [dictionary objectForKey:@"reply_count"];
    
    //    NSLog(@"%%%%%%%%@,********%@",visit_count,reply_count);
    
    self.watchLabel.adjustsFontSizeToFitWidth = YES;
    self.watchLabel.text = [NSString stringWithFormat:@"%@",visit_count];
    self.messageLabel.text = [NSString stringWithFormat:@"%@",reply_count];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
