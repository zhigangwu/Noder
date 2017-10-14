//
//  UnreadMessageCell.h
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnreadMessageCell : UITableViewCell

@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *durationLabel;

@property (nonatomic, strong) UIImageView *imageview;


- (void)configWithItem:(NSDictionary *)dic;


@end
