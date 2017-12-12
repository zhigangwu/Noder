//
//  DetailButtomView.m
//  Noder
//
//  Created by 吴志刚 on 28/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "DetailBottomView.h"
#import "Masonry.h"
#import "ControllerManager.h"

@implementation DetailBottomView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CALayer *viewlayer = [self layer];
        [viewlayer setShadowOpacity:0];
        [viewlayer setBorderWidth:0.5];
        [viewlayer setBorderColor:[ [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1/1.0] CGColor]];
        
        self.grayButton = [[UIButton alloc] init];
        self.brightButton = [[UIButton alloc] init];
        UIButton *commentButton = [[UIButton alloc] init];
        UIButton *refreshButton = [[UIButton alloc] init];
        
        [self addSubview:self.grayButton];
        [self addSubview:self.brightButton];
        [self addSubview:commentButton];
        [self addSubview:refreshButton];

        [self.grayButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self).with.offset(16);
            make.top.equalTo(self).with.offset(18);
            make.size.mas_offset(CGSizeMake(20, 20));
        }];
        
        [self.brightButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(18);
            make.left.equalTo(self.grayButton.mas_right).with.offset(16.9);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [commentButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(9);
            make.left.equalTo(self.brightButton.mas_right).with.offset(81.9);
            make.size.mas_equalTo(CGSizeMake(61, 37));
        }];
    
        [refreshButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(18.7);
            make.right.equalTo(self).with.offset(-16);
            make.size.mas_equalTo(CGSizeMake(20, 18));
        }];
        
        
        [commentButton setImage:[UIImage imageNamed:@"Group 2"] forState:UIControlStateNormal];
        [commentButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
        
        [refreshButton setImage:[UIImage imageNamed:@"Group-3"] forState:UIControlStateNormal];
        [commentButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)comment:(UIButton *)sender
{
    if (self.commentdelegate && [self.commentdelegate respondsToSelector:@selector(commentButton:)]) {
        [self.commentdelegate commentButton:sender];
    }
}

- (void)refresh:(UIButton *)sender
{
    if (self.RefreshDelegate && [self.RefreshDelegate respondsToSelector:@selector(refreshButton:)]) {
        [self.RefreshDelegate refreshButton:sender];
    }
}


@end
