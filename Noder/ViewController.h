//
//  ViewController.h
//  Noder
//
//  Created by alienware on 2017/2/10.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDTableViewCell.h"

#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import "UIImage+GIF.h"
#import "NSData+ImageContentType.h"

@interface ViewController : UITableViewController

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, strong) NSDictionary *dictionary;

@end

