//
//  RecentReplyCell.h
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentReplyCell : UITableViewCell

@property (nonatomic, weak) UILabel *TitleLabel;
@property (nonatomic, weak) UILabel *durationLabel;
@property (nonatomic, retain) UIImageView *ImageView;

- (void)configWithItem:(NSDictionary *)dic;

@end
