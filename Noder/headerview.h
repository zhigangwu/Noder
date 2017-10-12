//
//  headerview.h
//  Noder
//
//  Created by alienware on 2017/7/15.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface headerview : UIView

- (void)configWithData:(NSDictionary *)dic;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageview;


- (instancetype)init;

@end
