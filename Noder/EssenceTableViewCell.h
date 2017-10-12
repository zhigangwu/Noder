//
//  EssenceTableViewCell.h
//  Noder
//
//  Created by alienware on 2017/6/5.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EssenceTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, retain) UIImageView *imageVIew;
@property (nonatomic, retain) UIWebView *webView;

@property (nonatomic, retain) UIImageView *eyeImageView;
@property (nonatomic, retain) UIImageView *messageIamgeView;

@property (nonatomic, retain) UILabel *watchLabel;
@property (nonatomic, retain) UILabel *messageLabel;

@property (nonatomic, weak) UILabel *durationLabel;//时长

- (void)configWithItem:(NSDictionary *)dictionary;


@end
