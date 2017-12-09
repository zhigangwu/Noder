//
//  DetailTopView.h
//  Noder
//
//  Created by 吴志刚 on 03/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTopView : UIView

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *loginnameLabel;
@property (nonatomic, strong) UILabel *postedLabel;// 创建时间

@property (nonatomic, strong) UILabel *watchLabel;
@property (nonatomic, strong) UILabel *messageLabel;


- (instancetype)init;

@end
