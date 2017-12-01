//
//  ComContentView.m
//  Noder
//
//  Created by 吴志刚 on 30/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "ComContentView.h"
#import "Masonry.h"
#import "ControllerManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ComContentView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *backButton = [[UIButton alloc] init]; //返回
        UILabel *label = [[UILabel alloc] init];
        UIImageView *imageview = [[UIImageView alloc] init];
        self.textView = [[UITextView alloc] init];
        self.submitView = [[UIView alloc] init];// 提交视图
        UIButton *submitButton = [[UIButton alloc] init];// 提交
        
        [self addSubview:backButton];
        [self addSubview:label];
        [self addSubview:imageview];
        [self addSubview:self.textView];
        [self.submitView addSubview:submitButton];
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self).with.offset(20);
            make.left.equalTo(self).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(backButton.mas_bottom).with.offset(50);
            make.left.equalTo(self).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(220, 40));
        }];
        
        [imageview mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(label);
            make.right.equalTo(self).with.offset(-8);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];

        [self.textView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(label.mas_bottom).with.offset(10);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        self.submitView.frame = CGRectMake(0, 0, self.frame.size.width, 55);
        
        [submitButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.submitView);
            make.left.equalTo(self.submitView);
            make.right.equalTo(self.submitView);
            make.bottom.equalTo(self.submitView);
        }];
        
        [backButton setImage:[UIImage imageNamed:@"iconDismiss"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        
        label.text = @"“有什么你就说吧”";
        label.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:25];
        
        [imageview sd_setImageWithURL:[ControllerManager shareManager].URLImage];
        imageview.backgroundColor = [UIColor greenColor];
        
        self.submitView.backgroundColor = [UIColor redColor];
        
        self.textView.delegate = self;
        [self.textView becomeFirstResponder];// 键盘直接开启
        self.textView.inputAccessoryView = self.submitView;
        self.textView.font = [UIFont fontWithName:@"AmericanTypewriter" size:16];
        
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (void)back:(UIButton *)sender
{
    if (self.backButtonDelegate && [self.backButtonDelegate respondsToSelector:@selector(backButton:)]) {
        [self.backButtonDelegate backButton:sender];
    }
}

- (void)submit:(UIButton *)sender
{
    if (self.submitButtonDelegate && [self.submitButtonDelegate respondsToSelector:@selector(submitButton:)]) {
        [self.submitButtonDelegate submitButton:sender];
    }
}








@end
