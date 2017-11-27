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
            make.left.equalTo(self.contentView).with.offset(16);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.imageView.mas_right).with.offset(16);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(100, 22));
        }];
        
        self.messageLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.messageLabel];
        
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.contentView).with.offset(-20);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        
        [self.messageLabel.layer setCornerRadius:11];
        [self.messageLabel.layer setMasksToBounds:YES];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.textColor = [UIColor whiteColor];
        self.messageLabel.backgroundColor = [UIColor redColor];
        
        self.imageView.image = [UIImage imageNamed:@"Rectangle 4"];
    }
    return self;
}

@end
