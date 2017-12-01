//
//  DetailButtomView.m
//  Noder
//
//  Created by 吴志刚 on 28/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "DetailBottomView.h"
#import "Masonry.h"

@implementation DetailBottomView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *backButton = [[UIButton alloc] init];// 返回
        UIButton *commentButton = [[UIButton alloc] init];// 评价详情
        UILabel *commentLabel = [[UILabel alloc] init];// 评价数量
        UIButton *comBotton = [[UIButton alloc] init];// 写评价
        
        [self addSubview:backButton];
        [self addSubview:commentButton];
        [self addSubview:commentLabel];
        [self addSubview:comBotton];
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self).with.offset(15);
            make.size.mas_offset(CGSizeMake(40, 40));
            make.centerY.equalTo(self);
        }];
        
        [commentButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(commentLabel.mas_left).with.offset(2);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    
        [commentLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [comBotton mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self);
            make.left.equalTo(commentLabel.mas_right).with.offset(10);
            make.right.equalTo(self).with.offset(-15);
            make.height.mas_equalTo(40);
        }];
        
        [backButton setImage:[UIImage imageNamed:@"iconBottomBack"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [commentButton setImage:[UIImage imageNamed:@"iconGrayComment"] forState:UIControlStateNormal];
        [commentButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
        
        commentLabel.text = @"11";
        commentLabel.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1/1.0];
        commentLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        
        [comBotton.layer setCornerRadius:5];
        [comBotton.layer setMasksToBounds:YES];
        comBotton.backgroundColor = [UIColor redColor];
        [comBotton setTitle:@"说点什么!" forState:UIControlStateNormal];
        [comBotton addTarget:self action:@selector(comconent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)backButton:(UIButton *)sender
{
    if (self.backdelegate && [self.backdelegate respondsToSelector:@selector(backview:)]) {
        [self.backdelegate backview:sender];
    }
}

- (void)comment:(UIButton *)sender
{
    if (self.commentdelegate && [self.commentdelegate respondsToSelector:@selector(commentButton:)]) {
        [self.commentdelegate commentButton:sender];
    }
}

- (void)comconent:(UIButton *)sender
{
    if (self.comCenterDelegate && [self.comCenterDelegate respondsToSelector:@selector(comCenterButton:)]) {
        [self.comCenterDelegate comCenterButton:sender];
    }
}


@end
