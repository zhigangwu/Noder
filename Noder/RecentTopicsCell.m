//
//  RecentTopicsCell.m
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "RecentTopicsCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+textColor.h"
#import "NSDate+TimeAgo.h"

@implementation RecentTopicsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *title = [UILabel new];
        UIImageView *imageview = [UIImageView new];
        [self.contentView addSubview:title];
        [self.contentView addSubview:imageview];
        
        title.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        title.textColor = [UIColor textColor];
        
        [imageview.layer setCornerRadius:25.85];
        [imageview.layer setMasksToBounds:YES];

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
        self.TitleLable = title;
    }
    return self;
}

- (void)configWithItem:(LoginRecent_topics *)recent_topics
{

    self.TitleLable.text = recent_topics.title;
    [self.ImageView sd_setImageWithURL:recent_topics.author.avatar_url];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
