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

@interface DetailViewController : UIViewController <BackViewDelegate,commentDelegate,comCenterDelegate>

@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) NSString *ZGreply_id;
@property (nonatomic, strong) NSNumber *reply_count;

@property (nonatomic, strong) DetailDataModel *detailModel;
@property (nonatomic, strong) DetailReplies *replies;

@property (nonatomic, strong) DetailBottomView *bottomView;

@end
