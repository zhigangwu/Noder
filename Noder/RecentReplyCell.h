//
//  RecentReplyCell.h
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDataModel.h"

@interface RecentReplyCell : UITableViewCell

//@property (nonatomic, strong) LoginRecent_replies *recent_replies;
@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UIImageView *ImageView;

- (void)configWithItem:(LoginRecent_replies *)recent_replies;

@end
