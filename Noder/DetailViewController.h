//
//  DetailViewController.h
//  Noder
//
//  Created by bawn on 15/06/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) NSDictionary *dic;

@property (nonatomic, strong) NSString *ZGreply_id;
@property (nonatomic, strong) NSNumber *reply_count;

@end
