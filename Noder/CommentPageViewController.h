//
//  CommentPageTableViewController.h
//  Noder
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbsUpAPI.h"
#import "MMJDIYHeader.h"
#import "CommentTableViewCell.h"
#import "DetailDataModel.h"

@interface CommentPageViewController : UITableViewController <CommentCellDelegate>

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSString *comAuthor_id;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSString *topic_id;
@property (nonatomic, strong) NSString *reply_id;

@property (nonatomic, strong) UIButton *ZG_upButton;
@property (nonatomic, strong) UIButton *ZG_evaButton;

@property (nonatomic, strong) NSString *string_id;

@property (nonatomic, strong) DetailDataModel *detailModel;



@end
