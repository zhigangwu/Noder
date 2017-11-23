//
//  CollectionCell.h
//  Noder
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionDataModel.h"

@interface CollectionCell : UITableViewCell

@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UIImageView *ImageView;


- (void)configWithItem:(CollectionDataModel *)collectionModel;

@end
