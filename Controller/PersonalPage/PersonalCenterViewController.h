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
#import "PersonalTableModle.h"

#import "MessageAPI.h"
#import "MessageDataModel.h"


@interface PersonalCenterViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString *loginname;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSString *messageString;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) headerview *Header;
@property (nonatomic, strong) PersonalDataModel *personalModel;

@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic, strong) MessageDataModel *messageModel;

@end
