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

@protocol CommentCellDelegate <NSObject>

- (void)pushToNewPage:(UIButton *)sender;

@end

@interface CommentTableViewCell : UITableViewCell <UIWebViewDelegate>

@property (nonatomic, weak) id<CommentCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *ZGimageView;
@property (nonatomic, strong) UILabel *ZGloginname;
@property (nonatomic, strong) UIWebView *ZGwebView;
@property (nonatomic, strong) UILabel *ZGdurationLabel;

@property (nonatomic, strong) UIButton *ZGupButton; //点赞
@property (nonatomic, strong) UIButton *ZGevaButton; //个人评价

- (void)configWithItem:(DetailReplies *)replies;
@end
