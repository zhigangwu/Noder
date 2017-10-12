//
//  CommentPageTableViewController.h
//  Noder
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentPageViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) NSString *comAuthor_id;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSString *topic_id;
@property (nonatomic, strong) NSString *reply_id;

@property (nonatomic, strong) UIButton *ZG_upButton;
@property (nonatomic, strong) UIButton *ZG_evaButton;




@end
