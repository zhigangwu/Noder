//
//  ReadMessageCell.h
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDataModel.h"

@interface ReadMessageCell : UITableViewCell

@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UIImageView *ImageView;

- (void)configWithItem:(Has_read_messages *)has_read_messages;


@end
