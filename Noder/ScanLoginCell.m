//
//  ScanLoginCell.m
//  Noder
//
//  Created by alienware on 2017/5/16.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ScanLoginCell.h"
#import "Masonry.h"


@implementation ScanLoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        UIImageView *titleimage = [UIImageView new];
        UILabel *labelB = [UILabel new];
        [self.contentView addSubview:labelB];
        [self.contentView addSubview:self.imageView];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).with.offset(16);
            make.top.equalTo(self.contentView).with.offset(13);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.centerY.mas_equalTo(@[labelB]);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [labelB mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView).with.offset(17);
            make.left.equalTo(self.imageView.mas_right).with.offset(16);
        }];
        labelB.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        labelB.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1/1.0];
        self.labelA = labelB;
        

    }
    return self;
}


@end
