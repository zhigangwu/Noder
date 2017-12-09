//
//  CommentTableViewCell.h
//  Noder
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Apress. All rights reserved.
//

//Protocol CommentTableViewCell


#import <UIKit/UIKit.h>
#import "DetailDataModel.h"
#import "ThumbsDataModel.h"

@protocol CommentCellDelegate <NSObject>

- (void)upButton:(UIButton *)sender;

@end

@protocol PersonalCommentDelegate <NSObject>

- (void)personalComButton:(UIButton *)sender;

@end

@interface CommentTableViewCell : UITableViewCell <UIWebViewDelegate>

@property (nonatomic, weak) id<CommentCellDelegate> CommentCellDelegate;
@property (nonatomic, weak) id<PersonalCommentDelegate> PersonalCommentDelegate;

@property (nonatomic, strong) UIImageView *ZGimageView;
@property (nonatomic, strong) UILabel *ZGloginname;
@property (nonatomic, strong) UILabel *ZGLabel;
@property (nonatomic, strong) UILabel *ZGdurationLabel;
@property (nonatomic, strong) UILabel *floorLabel;

@property (nonatomic, strong) UIButton *ZGupButton; //点赞
@property (nonatomic, strong) UIButton *ZGevaButton; //个人评价

@property (nonatomic, strong) ThumbsDataModel *thumbsModel;
@property (nonatomic, strong) DetailDataModel *detailModel;

- (void)configWithItem:(DetailReplies *)replies;

@end
