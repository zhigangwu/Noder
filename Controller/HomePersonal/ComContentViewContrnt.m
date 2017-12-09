//
//  ComContentViewContrnt.m
//  Noder
//
//  Created by Mac on 2017/9/15.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ComContentViewContrnt.h"
#import "Masonry.h"
#import "comContentAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ControllerManager.h"


@interface ComContentViewContrnt ()


@end

@implementation ComContentViewContrnt

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.comContentView = [[ComContentView alloc] init];
    [self.view addSubview:self.comContentView];
    [self.comContentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.comContentView.backButtonDelegate = self;
    self.comContentView.submitButtonDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)backButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitButton:(UIButton *)sender
{
    self.QRCodeString = [ControllerManager shareManager].string;

    comContentAPI *comconAPI = [[comContentAPI alloc] init];
    comconAPI.topic_id = [ControllerManager shareManager].reply_ID;
    comconAPI.requestArgument = @{@"accesstoken" : self.QRCodeString,
                                      @"content" : self.comContentView.textView.text,
                                  @"reply_id" : [ControllerManager shareManager].reply_ID,
                                      };
    [comconAPI startWithBlockSuccess:^(__kindof LCBaseRequest *request){
        NSDictionary *dictionary = request.responseJSONObject;
        NSLog(@"dictionary = %@",dictionary);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:NULL];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










@end
