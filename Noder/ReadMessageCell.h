//
//  ReadMessageCell.h
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadMessageCell : UITableViewCell

@property (nonatomic, weak) UILabel *TitleLabel;
@property (nonatomic, weak) UILabel *durationLabel;

@property (nonatomic, retain) UIImageView *ImageView;

- (void)configWithItem:(NSDictionary *)dic;


@end
