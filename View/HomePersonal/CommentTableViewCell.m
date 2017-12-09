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
    self.ZGupButton = [[UIButton alloc] init];
    self.ZGevaButton = [[UIButton alloc] init];
    self.floorLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.ZGimageView];
    [self.contentView addSubview:self.ZGloginname];
    [self.contentView addSubview:self.ZGLabel];
    [self.contentView addSubview:self.ZGdurationLabel];
    [self.contentView addSubview:self.ZGupButton];
    [self.contentView addSubview:self.ZGevaButton];
    [self.contentView addSubview:self.floorLabel];
    
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
        make.bottom.equalTo(_ZGupButton.mas_top).with.offset(-8);
        make.height.mas_equalTo(18);
    }];
    
    [self.ZGupButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_ZGdurationLabel.mas_bottom).with.offset(8);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
        make.right.equalTo(_ZGevaButton.mas_left).with.offset(-200);
        make.bottom.equalTo(self.contentView).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.ZGevaButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(_ZGupButton.mas_top);
        make.right.equalTo(self.contentView).with.offset(-16);
        make.bottom.mas_equalTo(_ZGupButton.mas_bottom);
    }];
    
    [self.floorLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView).with.offset(12);
        make.right.equalTo(self.contentView).with.offset(-13);
        make.height.mas_equalTo(17);
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
    
    [self.ZGupButton addTarget:self action:@selector(ZGupButtonaction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ZGevaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.ZGevaButton setImage:[UIImage imageNamed:@"iconGrayComment"] forState:UIControlStateNormal];
    [self.ZGevaButton addTarget:self action:@selector(personalComment:) forControlEvents:UIControlEventTouchUpInside];
    
    self.floorLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.floorLabel.textColor = [UIColor textColorB];
 
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

//    if ([replies.ups containsObject:[ControllerManager shareManager].id]) {
//        [self.ZGupButton setImage:[UIImage imageNamed:@"Shape Copy"] forState:UIControlStateNormal];
//    } else {
//        [self.ZGupButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
//    }

}



- (void)ZGupButtonaction:(id)sender
{
    if (self.CommentCellDelegate && [self.CommentCellDelegate respondsToSelector:@selector(upButton:)]) {
        [self.CommentCellDelegate upButton:sender];
    }
}

- (void)personalComment:(id)sender
{
    if (self.PersonalCommentDelegate && [self.PersonalCommentDelegate respondsToSelector:@selector(personalComButton:)]) {
        [self.PersonalCommentDelegate personalComButton:sender];
    }
}










@end
