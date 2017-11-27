//
//  RecruitmentTableViewCell.h
//  Noder
//
//  Created by alienware on 2017/6/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDataModel.h"

@interface RecruitmentTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *topImage;

@property (nonatomic, strong) UIImageView *image_view;
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIImageView *eyeImageView;
@property (nonatomic, strong) UIImageView *messageIamgeView;

@property (nonatomic, strong) UILabel *watchLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UILabel *durationLabel;//时长

- (void)configWithItem:(JobDataModel *)jobModel;


@end
