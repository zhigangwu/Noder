//
//  RecentTopicsViewController.h
//  Noder
//
//  Created by alienware on 2017/5/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDataModel.h"

@interface RecentTopicsViewController : UITableViewController

@property (nonatomic, strong) LoginDataModel *loginModel;
@property (nonatomic, strong) LoginRecent_topics *recent_topics;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *TopicsLoginname;

@end
