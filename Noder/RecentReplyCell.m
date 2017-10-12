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
        
        UIImageView *imageview = [UIImageView new];
        UILabel *title = [UILabel new];
        UILabel *duration = [UILabel new];
        [self.contentView addSubview:imageview];
        [self.contentView addSubview:title];
        [self.contentView addSubview:duration];
        
        title.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        title.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1/1.0];
        
        [imageview.layer setCornerRadius:25.85];
        [imageview.layer setMasksToBounds:YES];

        duration.text = @"4小时";
        duration.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        duration.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1/1.0];
        
        [imageview mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).with.offset(15.9);
            make.size.mas_equalTo(CGSizeMake(52, 51.7));
        }];
        self.ImageView = imageview;
        
        [title mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView).with.offset(11.6);
            make.left.equalTo(imageview.mas_right).with.offset(11);
        }];
        self.TitleLabel = title;
        
        [duration mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.contentView).with.offset(-9.6);
            make.left.equalTo(imageview.mas_right).with.offset(14);
        }];
        self.durationLabel = duration;

    }
    return self;
}

- (void)configWithItem:(NSDictionary *)dicationary
{
    self.TitleLabel.text = [dicationary objectForKey:@"title"];
    
    NSURL *url = [NSURL URLWithString:dicationary[@"author"][@"avatar_url"]];
    [self.ImageView sd_setImageWithURL:url];
    
}









@end
