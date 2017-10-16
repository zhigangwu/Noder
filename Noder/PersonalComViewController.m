//
//  PersonalComViewController.m
//  Noder
//
//  Created by Mac on 2017/9/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "PersonalComViewController.h"
#import "Masonry.h"
#import "comContentAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ControllerManager.h"

@interface PersonalComViewController ()

@end

@implementation PersonalComViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *rightButton = [[UIButton alloc] init];
    [self.view addSubview:rightButton];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(release:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    UIView *topview = [[UIView alloc] init];
    self.imageview = [[UIImageView alloc] init];
    self.contentView = [[UITextView alloc] init];
    
    [self.view addSubview:topview];
    [topview addSubview:self.imageview];
    [self.view addSubview:self.contentView];
    
    [topview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(topview.mas_bottom).with.offset(-10);
        make.center.equalTo(topview);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(topview.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-60);
    }];
    
    [topview setBackgroundColor:[UIColor redColor]];
    [self.imageview setBackgroundColor:[UIColor yellowColor]];
    [_imageview.layer setCornerRadius:25];
    
    self.contentView.text = @"嘿！说点什么吧。。。。。。";
    self.contentView.font = [UIFont boldSystemFontOfSize:18];
    
    
    NSDictionary *dic = [ControllerManager shareManager].dic;
    [self.imageview sd_setImageWithURL:dic[@"avatar_url"]];
    self.contentView.delegate = self;
    
}

- (void)release:(UIButton *)sender
{
    self.QRCodeString = [ControllerManager shareManager].string;
    
    if (self.QRCodeString != nil) {
        comContentAPI *comconAPI = [[comContentAPI alloc] init];
        comconAPI.topic_id = self.topic_id;
        comconAPI.requestArgument = @{@"accesstoken" : self.QRCodeString,
                                      @"content" : self.contentView.text,
                                      @"reply_id" : self.reply_id,
                                      };
        
        NSLog(@"comconAPI.requestArgument = %@",comconAPI.requestArgument);
        
        [comconAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
            NSDictionary *dictionary = request.responseJSONObject;
            NSLog(@"dictionary = %@",dictionary);
            [self.navigationController popViewControllerAnimated:YES];
        } failure:NULL];
    } else
        NSLog(@"请输入内容！");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([_contentView.text isEqualToString:@"嘿！说点什么吧。。。。。。"]) {
        _contentView.text = @"";
    }
}



@end
