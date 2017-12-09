//
//  UnreadMessageTableViewController.h
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDataModel.h"

@interface UnreadMessageTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MessageDataModel *messageModel;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UITableView *tableview;

@end
