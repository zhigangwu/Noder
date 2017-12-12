//
//  CommentTableViewCell.m
//  Noder
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+TimeAgo.h"
#import "ControllerManager.h"
#import "ThumbsUpAPI.h"
#import "UIColor+textColor.h"
#import "UIColor+textColorB.h"

#import "UILabel+LabelHeight.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCell];
        
    }
    
    return self;
}

- (void)initCell
{
    self.ZGimageView = [[UIImageView alloc] init];
    self.ZGloginname = [[UILabel alloc] init];
    self.ZGLabel = [[UILabel alloc] init];
    self.ZGdurationLabel = [[UILabel alloc] init];
    self.ZGlikeupButton = [[UIButton alloc] init];// 点赞
    self.ZGlikedupButton = [[UIButton alloc] init]; // 取消点赞
    self.ZGevaButton = [[UIButton alloc] init];// 个人评价
    self.floorLabel = [[UILabel alloc] init];
    self.upLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.ZGimageView];
    [self.contentView addSubview:self.ZGloginname];
    [self.contentView addSubview:self.ZGLabel];
    [self.contentView addSubview:self.ZGdurationLabel];
    [self.contentView addSubview:self.ZGlikeupButton];
    [self.contentView addSubview:self.ZGlikedupButton];
    [self.contentView addSubview:self.ZGevaButton];
    [self.contentView addSubview:self.floorLabel];
    [self.contentView addSubview:self.upLabel];
    
    [self.ZGimageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView).with.offset(16);
        make.left.equalTo(self.contentView).with.offset(16);
//        make.right.equalTo(_ZGloginname.mas_left).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.ZGloginname mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView).with.offset(15);
        make.left.equalTo(self.ZGimageView.mas_right).with.offset(16);
//        make.right.equalTo(self.contentView).with.offset(-200);
        make.bottom.equalTo(self.ZGLabel.mas_top).with.offset(-8);
        make.height.mas_equalTo(17);
    }];

    [self.ZGLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_ZGloginname.mas_bottom).with.offset(8);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
        make.right.equalTo(self.contentView).with.offset(-16);
        make.bottom.equalTo(_ZGdurationLabel.mas_top).with.offset(-8);
    }];
    
    [self.ZGdurationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.ZGLabel.mas_bottom).with.offset(8);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
//        make.right.equalTo(self.contentView).with.offset(-150);
        make.bottom.equalTo(self.contentView).with.offset(-17);
        make.height.mas_equalTo(14);
    }];
    
    [self.ZGlikeupButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.ZGevaButton.mas_left).with.offset(-19);
        make.bottom.equalTo(self.contentView).with.offset(-17);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self.ZGlikedupButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.ZGevaButton.mas_left).with.offset(-19);
        make.bottom.equalTo(self.contentView).with.offset(-17);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];

    
    [self.ZGevaButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(CGSizeMake(13, 13));
        make.right.equalTo(self.contentView).with.offset(-16);
        make.bottom.mas_equalTo(self.contentView).with.offset(-17);
    }];
    
    [self.floorLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView).with.offset(12);
        make.right.equalTo(self.contentView).with.offset(-13);
        make.height.mas_equalTo(17);
    }];
    
    [self.upLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.ZGlikeupButton.mas_left).with.offset(-4);
        make.bottom.equalTo(self.contentView).with.offset(-17);
        make.size.mas_equalTo(CGSizeMake(8, 17));
    }];
    
    CALayer *layer = [self.ZGimageView layer];
    [layer setMasksToBounds:YES];
    [layer setShadowOpacity:0];
    [layer setCornerRadius:20];
    [layer setBorderWidth:0.5];
    [layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    self.ZGLabel.numberOfLines = 0;
    [self.ZGLabel sizeToFit];
    
    self.ZGloginname.textColor =  [UIColor textColorB];
    self.ZGloginname.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    
    self.ZGLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.ZGLabel.textColor = [UIColor textColor];
    
    self.ZGdurationLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1/1.0];
    self.ZGdurationLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    
    [self.ZGevaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.ZGevaButton setImage:[UIImage imageNamed:@"message-1"] forState:UIControlStateNormal];
    [self.ZGevaButton addTarget:self action:@selector(personalComment:) forControlEvents:UIControlEventTouchUpInside];
    
    self.floorLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.floorLabel.textColor = [UIColor textColorB];
    
    self.upLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.upLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1/1.0];
}

- (void)configWithItem:(DetailReplies *)replies
{
    self.ZGloginname.text = replies.author.loginname;
    
    self.ZGLabel.text = replies.content;
//    UILabel 加载HTML
    NSAttributedString *attString = [[NSAttributedString alloc] initWithData:[replies.content dataUsingEncoding:NSUnicodeStringEncoding]
                                                                     options:@{
                                                                               NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType
                                                                               }
                                                          documentAttributes:nil
                                                                       error:nil];
    self.ZGLabel.attributedText = attString;
    
    [self.ZGimageView sd_setImageWithURL:replies.author.avatar_url];
    
    NSString *dateStr = replies.create_at;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    self.ZGdurationLabel.text = [date timeAgo];
    
    self.upLabel.text = [NSString stringWithFormat:@"%ld",replies.ups.count];
    
    if ([replies.ups containsObject:[ControllerManager shareManager].id]) {
        self.ZGlikeupButton.hidden = YES;
        [self.ZGlikedupButton setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal];
        [self.ZGlikedupButton addTarget:self action:@selector(ZGlikedupButton:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.ZGlikedupButton.hidden = YES;
        [self.ZGlikeupButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [self.ZGlikeupButton addTarget:self action:@selector(ZGlikeupButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}



- (void)ZGlikedupButton:(id)sender
{
    if (self.LikedupButtonDelegate && [self.LikedupButtonDelegate respondsToSelector:@selector(likedupButton:)]) {
        [self.LikedupButtonDelegate likedupButton:sender];
    }
}

- (void)ZGlikeupButton:(id)sender
{
    if (self.LikeupButtonDelegate && [self.LikeupButtonDelegate respondsToSelector:@selector(likeupButton:)]) {
        [self.LikeupButtonDelegate likeupButton:sender];
    }
}


- (void)personalComment:(id)sender
{
    if (self.PersonalCommentDelegate && [self.PersonalCommentDelegate respondsToSelector:@selector(personalComButton:)]) {
        [self.PersonalCommentDelegate personalComButton:sender];
    }
}










@end
