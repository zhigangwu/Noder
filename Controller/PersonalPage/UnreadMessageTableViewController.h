//
//  UnreadMessageTableViewController.h
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDataModel.h"
#import "UIScrollView+EmptyDataSet.h"

@interface UnreadMessageTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) MessageDataModel *messageModel;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) Hasnot_read_messages *hasnot_read;

@end
