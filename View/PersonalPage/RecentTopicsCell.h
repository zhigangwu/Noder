//
//  RecentTopicsCell.h
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDataModel.h"

@interface RecentTopicsCell : UITableViewCell

@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UIImageView *ImageView;

- (void)configWithItem:(LoginRecent_topics *)recent_topics;


@end
