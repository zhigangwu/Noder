//
//  UnreadMessageCell.m
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "UnreadMessageCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+textColor.h"


@implementation UnreadMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _TitleLabel = [[UILabel alloc] init];
        _imageview = [[UIImageView alloc] init];

        [self.contentView addSubview:_TitleLabel];
        [self.contentView addSubview:_imageview];

        
        self.TitleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        self.TitleLabel.textColor = [UIColor textColor];
        
        [_imageview.layer setCornerRadius:25.85];
        [_imageview.layer setMasksToBounds:YES];
        
        [_imageview mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).with.offset(15.9);
            make.size.mas_equalTo(CGSizeMake(52, 51.7));
        }];
        
        [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView).with.offset(11.6);
            make.left.equalTo(_imageview.mas_right).with.offset(11);
        }];
        

        
        
    }
    return self;
}

- (void)configWithItem:(NSDictionary *)dicationary
{
    self.TitleLabel.text = [dicationary objectForKey:@"title"];
    
    [_imageview sd_setImageWithURL:dicationary[@"author"][@"avatar_url"]];
    

//    MessageCountAPI *messAPI = [[MessageCountAPI alloc] init];
//    NSString *access = [ControllerManager shareManager].string;
//    messAPI.requestArgument = @{@"accesstoken" : access};
//    [messAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
//        NSDictionary *dic = request.responseJSONObject;
//        NSLog(@"dic = %@",dic);
//        _messageCount.text = dic[@"data"];
//    } failure:NULL];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
