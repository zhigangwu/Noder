//
//  PlateSelectionCell.m
//  Noder
//
//  Created by Mac on 2017/9/27.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "PlateSelectionCell.h"
#import "Masonry.h"

@implementation PlateSelectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(104, 21));
        }];
        
        _label.textAlignment = UITextAlignmentCenter;
        _label.font = [UIFont fontWithName:@".SFNSDisplay" size:20];
        _label.textColor = [UIColor colorWithRed:0/255.0 green:118/255.0 blue:255/255.0 alpha:1/1.0];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
