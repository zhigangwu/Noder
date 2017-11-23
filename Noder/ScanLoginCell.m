//
//  ScanLoginCell.m
//  Noder
//
//  Created by alienware on 2017/5/16.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ScanLoginCell.h"
#import "Masonry.h"
#import "MessageCountAPI.h"
#import "ControllerManager.h"


@implementation ScanLoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView).with.offset(10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make){
            
        }];
        
        self.messageLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.contentView).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
