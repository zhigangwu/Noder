//
//  CollectionCell.m
//  Noder
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "CollectionCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *title = [UILabel new];
        UIImageView *imageview = [UIImageView new];
        [self.contentView addSubview:title];
        [self.contentView addSubview:imageview];
        
        title.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        title.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1/1.0];
        
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
        self.TitleLabel = title;
    }
    return self;
}

- (void)configWithItem:(NSDictionary *)dicationary
{
    self.TitleLabel.text = [dicationary objectForKey:@"title"];
    
    [self.ImageView sd_setImageWithURL:dicationary[@"author"][@"avatar_url"]];
}

@end
