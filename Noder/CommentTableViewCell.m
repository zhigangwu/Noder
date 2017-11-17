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
    self.ZGwebView = [[UIWebView alloc] init];
    self.ZGdurationLabel = [[UILabel alloc] init];
    self.ZGupButton = [[UIButton alloc] init];
    self.ZGevaButton = [[UIButton alloc] init];
    
    [self.contentView addSubview:_ZGimageView];
    [self.contentView addSubview:_ZGloginname];
    [self.contentView addSubview:_ZGwebView];
    [self.contentView addSubview:_ZGdurationLabel];
    [self.contentView addSubview:_ZGupButton];
    [self.contentView addSubview:_ZGevaButton];
    
    [_ZGimageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView).with.offset(16);
        make.left.equalTo(self.contentView).with.offset(16);
        make.right.equalTo(_ZGloginname.mas_left).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_ZGloginname mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView).with.offset(16);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
        make.right.equalTo(self.contentView).with.offset(-200);
        make.bottom.equalTo(_ZGwebView.mas_top).with.offset(-8);
        make.height.mas_equalTo(17);
    }];
    
    [_ZGwebView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_ZGloginname.mas_bottom).with.offset(8);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
        make.right.equalTo(self.contentView).with.offset(-16);
        make.bottom.equalTo(_ZGdurationLabel.mas_top).with.offset(-8);
    }];
    
    [_ZGdurationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_ZGwebView.mas_bottom).with.offset(8);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
        make.right.equalTo(self.contentView).with.offset(-150);
        make.bottom.equalTo(_ZGupButton.mas_top).with.offset(-8);
        make.height.mas_equalTo(14);
    }];
    
    [_ZGupButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_ZGdurationLabel.mas_bottom).with.offset(8);
        make.left.equalTo(_ZGimageView.mas_right).with.offset(16);
        make.right.equalTo(_ZGevaButton.mas_left).with.offset(-200);
        make.bottom.equalTo(self.contentView).with.offset(-20);
    }];
    
    [_ZGevaButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(_ZGupButton.mas_top);
        make.right.equalTo(self.contentView).with.offset(-16);
        make.bottom.mas_equalTo(_ZGupButton.mas_bottom);
    }];
    
    NSDictionary *dic = [ControllerManager shareManager].dictionary;
    NSString *success = dic[@"success"];
    if (success.boolValue == false) {
        self.ZGupButton.hidden = YES;
        self.ZGevaButton.hidden = YES;
    }
}

- (void)configWithItem:(NSDictionary *)dictionary
{
    self.ZGloginname.text = dictionary[@"author"][@"loginname"];

    NSString *string = [dictionary valueForKey:@"content"];
    [_ZGwebView loadHTMLString:string baseURL:nil];

    [self.ZGimageView sd_setImageWithURL:dictionary[@"author"][@"avatar_url"]];

    NSString *dateStr = dictionary[@"create_at"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    self.ZGdurationLabel.text = [date timeAgo];

//    self.floorLabel.text = @"555";

//    self.thupID = dictionary[@"id"];

    [_ZGupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_ZGupButton setTitle:@"赞" forState:UIControlStateNormal];
    [self.ZGupButton addTarget:self action:@selector(ZGupButtonaction:) forControlEvents:UIControlEventTouchUpInside];

    [_ZGevaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_ZGevaButton setTitle:@"评" forState:UIControlStateNormal];

}



- (void)ZGupButtonaction:(id)sender{

    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToNewPage:)]) {
        [self.delegate pushToNewPage:sender];
    }

}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}








@end
