//
//  CommentPageTableViewController.h
//  Noder
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbsUpAPI.h"
#import "CommentTableViewCell.h"
#import "DetailDataModel.h"
#import "ThumbsDataModel.h"
#import "DetailBottomView.h"
#import "CommentBottomView.h"

@interface CommentPageViewController : UIViewController <LikedupButtonDelegate,LikeupButtonDelegate,UITableViewDelegate,UITableViewDataSource,PersonalCommentDelegate,UITextViewDelegate>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSString *comAuthor_id;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSString *topic_id;
@property (nonatomic, strong) NSString *reply_id;

@property (nonatomic, strong) UIButton *ZG_upButton;//点赞
@property (nonatomic, strong) UIButton *ZG_evaButton;// 个人评价

@property (nonatomic, strong) DetailDataModel *detailModel;
@property (nonatomic, strong) DetailReplies *reply;
@property (nonatomic, strong) ThumbsDataModel *thumbsModel;

@property (nonatomic, strong) CommentBottomView *bottomView;

- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText;

@end
