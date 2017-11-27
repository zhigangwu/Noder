//
//  DevTableViewCell.h
//  Noder
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DevDataModel.h"

@interface DevTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *topImage;

@property (nonatomic, strong) UIImageView *image_view;
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIImageView *eyeImageView;
@property (nonatomic, strong) UIImageView *messageIamgeView;

@property (nonatomic, strong) UILabel *watchLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UILabel *durationLabel;//时长

- (void)configWithItem:(DevDataModel *)devModel;

@end
