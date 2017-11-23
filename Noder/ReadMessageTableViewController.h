//
//  ReadMessageTableViewController.h
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDataModel.h"

@interface ReadMessageTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) MessageDataModel *messageModel;

@end
