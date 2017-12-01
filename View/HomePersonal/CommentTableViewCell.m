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
    
    [self.contentView addSubview:self.ZGimageView];
    [self.contentView addSubview:self.ZGloginname];
    [self.contentView addSubview:self.ZGLabel];
    [self.contentView addSubview:self.ZGdurationLabel];
    [self.contentView addSubview:self.ZGupButton];
    [self.contentView addSubview:self.ZGevaButton];
    
    [self.ZGimageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView).with.offset(16);
        make.left.equalTo(self.contentView).with.offset(16);
        make.right.equalTo(_ZGloginname.mas_left).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.ZGloginname mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView).with.offset(16);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
//        make.right.equalTo(self.contentView).with.offset(-200);
        make.bottom.equalTo(self.ZGLabel.mas_top).with.offset(-8);
        make.height.mas_equalTo(18);
    }];

    [self.ZGLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_ZGloginname.mas_bottom).with.offset(20);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
        make.right.equalTo(self.contentView).with.offset(-16);
        make.bottom.equalTo(_ZGdurationLabel.mas_top).with.offset(-8);
    }];
    
    [self.ZGdurationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.ZGLabel.mas_bottom).with.offset(8);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
        make.right.equalTo(self.contentView).with.offset(-150);
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
    
    if ([ControllerManager shareManager].success == false) {
        self.ZGupButton.hidden = YES;
        self.ZGevaButton.hidden = YES;
    }
    
    [self.ZGimageView.layer setCornerRadius:15];
    [self.ZGimageView.layer setMasksToBounds:YES];
    
    self.ZGLabel.numberOfLines = 0;
    [self.ZGLabel sizeToFit];
    
    self.ZGloginname.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1/1.0];
    self.ZGloginname.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
    [self.ZGloginname.layer setCornerRadius:3];
    [self.ZGloginname.layer setMasksToBounds:YES];
    
    self.ZGdurationLabel.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1/1.0];
    self.ZGdurationLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
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
    
    [self.ZGupButton setImage:[UIImage imageNamed:@"iconSmallNormalStar"] forState:UIControlStateNormal];
    [self.ZGupButton addTarget:self action:@selector(ZGupButtonaction:) forControlEvents:UIControlEventTouchUpInside];

    [_ZGevaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_ZGevaButton setTitle:@"评" forState:UIControlStateNormal];

}



- (void)ZGupButtonaction:(id)sender
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToNewPage:)]) {
        [self.delegate pushToNewPage:sender];
    }

}








@end
