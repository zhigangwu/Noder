//
//  RecentReplyViewController.h
//  Noder
//
//  Created by alienware on 2017/5/22.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDataModel.h"

@interface RecentReplyViewController : UITableViewController

@property (nonatomic, strong) LoginDataModel *loginModel;
@property (nonatomic, strong) LoginRecent_replies *recent_replies;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *recenrLoginname;

@end
