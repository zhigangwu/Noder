//
//  PersonalCenterViewController.h
//  Noder
//
//  Created by alienware on 2017/5/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headerview.h"
#import "PersonalDataModel.h"


@interface PersonalCenterViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString *loginname;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSString *messageString;

@property (nonatomic, strong) headerview *Header;
@property (nonatomic, strong) PersonalDataModel *personalModel;

@end
