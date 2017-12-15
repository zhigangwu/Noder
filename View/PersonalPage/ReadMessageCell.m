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
#import "UIColor+TitleColor.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeAgo.h"
#import "UIFont+SetFont.h"

@implementation ReadMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.TitleLabel = [[UILabel alloc] init];
        self.themelabel = [[UILabel alloc] init];
        self.contentLabel = [[UILabel alloc] init];
        self.durationLabel = [[UILabel alloc] init];
        self.ImageView = [[UIImageView alloc] init];
        UIView *spacingView = [[UIView alloc] init];// 间隙
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:self.ImageView];
        [self.contentView addSubview:self.themelabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.TitleLabel];
        [self.contentView addSubview:self.durationLabel];
        [self.contentView addSubview:spacingView];
        [self.contentView addSubview:lineView];
        
        [self.ImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView).with.offset(12.4);
            make.left.equalTo(self.contentView).with.offset(15.9);
            make.size.mas_equalTo(CGSizeMake(52, 52));
        }];
        
        [self.TitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView).with.offset(11.6);
            make.left.equalTo(self.ImageView.mas_right).with.offset(12);
            make.right.equalTo(self.contentView);
        }];
        
        [self.themelabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.TitleLabel.mas_bottom).with.offset(7);
            make.left.equalTo(self.ImageView.mas_right).with.offset(14);
            make.right.equalTo(self.contentView).with.offset(-12);
            make.height.mas_equalTo(17);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.themelabel.mas_bottom).with.offset(11.2);
            make.left.equalTo(self.ImageView.mas_right).with.offset(12);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(1.1);
        }];
        
        [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView).with.offset(13.8);
            make.right.equalTo(self.contentView).with.offset(-12);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(lineView.mas_bottom).with.offset(8.7);
            make.left.equalTo(self.ImageView.mas_right).with.offset(12);
            make.right.equalTo(self.contentView).with.offset(-14);
            make.bottom.equalTo(self.contentView).with.offset(-14);
        }];
        
        [spacingView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(20);
        }];
        


    
        self.TitleLabel.font = [UIFont ZGFontB];
        self.TitleLabel.textColor = [UIColor textColor];
        
        self.themelabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        self.themelabel.textColor = [UIColor textColor];
        
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.contentLabel.textColor = [UIColor textColor];
        
        CALayer *layer = [self.ImageView layer];
        [layer setMasksToBounds:YES];
        [layer setShadowOpacity:0];
        [layer setCornerRadius:26];
        [layer setBorderWidth:0.5];
        [layer setBorderColor:[[UIColor grayColor] CGColor]];
        
        self.durationLabel.font = [UIFont ZGFontC];
        self.durationLabel.textColor = [UIColor textColorB];
        
        spacingView.backgroundColor = [UIColor backgroundcolor];
        lineView.backgroundColor = [UIColor backgroundcolor];
//        [self drawLine];
    }
    return self;
}

- (void)configWithItem:(Has_read_messages *)has_read_messages
{
    self.TitleLabel.text = has_read_messages.author.loginname;
    
    self.themelabel.text = [NSString stringWithFormat:@"主题:%@",has_read_messages.topic.title];
    
    self.contentLabel.text = has_read_messages.reply.content;
    //    UILabel 加载HTML
    NSAttributedString *attString = [[NSAttributedString alloc] initWithData:[has_read_messages.reply.content dataUsingEncoding:NSUnicodeStringEncoding]
                                                                     options:@{
                                                                               NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType
                                                                               }
                                                          documentAttributes:nil
                                                                       error:nil];
    self.contentLabel.attributedText = attString;

    
    [self.ImageView sd_setImageWithURL:has_read_messages.author.avatar_url];
    
    NSString *dateStr = has_read_messages.topic.last_reply_at;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    self.durationLabel.text = [date timeAgo];
}



@end
