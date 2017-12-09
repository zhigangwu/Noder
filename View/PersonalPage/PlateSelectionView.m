//
//  PlateSelectionView.m
//  Noder
//
//  Created by 吴志刚 on 09/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "PlateSelectionView.h"
#import "Masonry.h"

@implementation PlateSelectionView

- (instancetype)init
{
    if (self = [super init]) {
        self.tableview = [[UITableView alloc] init];
        UIView *cancelView = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        self.cancelButton = [[UIButton alloc] init];
        [self addSubview:self.tableview];
        [self addSubview:cancelView];
        [cancelView addSubview:label];
        [cancelView addSubview:self.cancelButton];
        
        [self.tableview mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self.cancelButton.mas_top).with.offset(-8);
            make.height.mas_equalTo(278);
        }];
        
        [cancelView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.tableview.mas_bottom).with.offset(8);
            make.left.equalTo(self).with.offset(10);
            make.right.equalTo(self).with.offset(-10);
            make.bottom.equalTo(self).with.offset(-8);
            make.height.mas_equalTo(58);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(cancelView);
            make.centerY.equalTo(cancelView);
            make.height.mas_equalTo(21);
        }];
        
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(cancelView);
            make.left.equalTo(cancelView);
            make.right.equalTo(cancelView);
            make.bottom.equalTo(cancelView);
        }];
                    
        cancelView.backgroundColor = [UIColor whiteColor];
        [cancelView.layer setCornerRadius:6];
        [cancelView.layer setMasksToBounds:YES];
        label.text = @"取消";
        label.font = [UIFont fontWithName:@".SFNSDisplay" size:20];
        label.textColor = [UIColor colorWithRed:0/255.0 green:118/255.0 blue:255/255.0 alpha:1/1.0];
    }
    return self;
}
@end
