//
//  CommentBottomView.m
//  Noder
//
//  Created by 吴志刚 on 11/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "CommentBottomView.h"
#import "Masonry.h"

@implementation CommentBottomView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.contentTextView = [[UITextView alloc] init];
        self.releasseLabel = [[UILabel alloc] init];
        self.releaseButton = [[UIButton alloc] init];
        
        [self addSubview:self.contentTextView];
        [self addSubview:self.releasseLabel];
        [self addSubview:self.releaseButton];
        
        [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self);
            make.left.equalTo(self).with.offset(16);
            make.right.equalTo(self.releaseButton.mas_left).with.offset(-27);
            make.height.mas_equalTo(38);
        }];
        
        [self.releasseLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self).with.offset(-13);
            make.size.mas_equalTo(CGSizeMake(28, 20));
            make.top.equalTo(self).with.offset(18);
        }];
        
        [self.releaseButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self).with.offset(-13);
            make.size.mas_equalTo(CGSizeMake(28, 20));
            make.top.equalTo(self).with.offset(18);
        }];
        
        [self.contentTextView.layer setCornerRadius:6];
        [self.contentTextView.layer setMasksToBounds:YES];
        self.contentTextView.backgroundColor =  [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1/1.0];
        self.contentTextView.text = @"填写评论…";
        self.contentTextView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        self.contentTextView.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1/1.0];

        
        self.releasseLabel.text = @"发布";
        self.releasseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.releasseLabel.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1/1.0];
    }
    return self;
}


@end
