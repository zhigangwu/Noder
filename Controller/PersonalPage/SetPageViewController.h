//
//  SetPageViewController.h
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface SetPageViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *arrayA;
@property (nonatomic, strong) NSArray *arrayB;

@end
