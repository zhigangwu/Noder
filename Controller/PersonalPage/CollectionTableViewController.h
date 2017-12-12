//
//  CollectionTableViewController.h
//  Noder
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionDataModel.h"

@interface CollectionTableViewController : UITableViewController

@property (nonatomic, strong) CollectionDataModel *collectionModel;
@property (nonatomic, strong) NSString *collectionLoginname;
@property (nonatomic, strong) NSArray *array;

@end
