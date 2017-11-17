//
//  RecentReplyCell.m
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "RecentReplyCell.h"
#import "Masonry.h"

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
        self.TitleLabel.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1/1.0];
        
        [self.ImageView.layer setCornerRadius:25.85];
        [self.ImageView.layer setMasksToBounds:YES];
        
        self.durationLabel.text = @"4小时";
        self.durationLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        self.durationLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1/1.0];

    }
    return self;
}

- (void)configWithItem:(NSDictionary *)dicationary
{
    self.TitleLabel.text = [dicationary objectForKey:@"title"];
    
    NSURL *url = [NSURL URLWithString:dicationary[@"author"][@"avatar_url"]];
    [self.ImageView sd_setImageWithURL:url];
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}










@end
