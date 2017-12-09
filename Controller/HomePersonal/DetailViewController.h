//
//  DetailViewController.h
//  Noder
//
//  Created by bawn on 15/06/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailDataModel.h"
#import "DetailBottomView.h"
#import "AllViewController.h"
#import "DetailTopView.h"
#import "ThumbsDataModel.h"

@interface DetailViewController : UIViewController <BackViewDelegate,commentDelegate,RefreshDelegate>

@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) NSString *ZGreply_id;
@property (nonatomic, strong) NSNumber *reply_count;

@property (nonatomic, strong) DetailDataModel *detailModel;
@property (nonatomic, strong) DetailReplies *replies;

@property (nonatomic, strong) DetailTopView *topView;
@property (nonatomic, strong) DetailBottomView *bottomView;

@property (nonatomic, strong) ThumbsDataModel *thumbsModel;

@end
