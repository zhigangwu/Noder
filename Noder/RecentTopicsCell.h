//
//  RecentTopicsCell.h
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentTopicsCell : UITableViewCell

@property (nonatomic, weak) UILabel *TitleLable;
@property (nonatomic, retain) UIImageView *ImageView;

- (void)configWithItem:(NSDictionary *)dic;


@end
