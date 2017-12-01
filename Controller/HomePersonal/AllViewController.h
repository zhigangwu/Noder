//
//  AllViewController.h
//  Noder
//
//  Created by alienware on 2017/6/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailBottomView.h"

@interface AllViewController : UITableViewController

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) DetailBottomView *bottomView;

@end
