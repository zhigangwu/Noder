//
//  CommentTableViewCell.h
//  Noder
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell <UIWebViewDelegate>

@property (nonatomic, strong) UIImageView *ZGimageView;
@property (nonatomic, strong) UILabel *ZGloginname;
@property (nonatomic, strong) UIWebView *ZGwebView;
@property (nonatomic, strong) UILabel *ZGdurationLabel;

@property (nonatomic, strong) UIButton *ZGupButton;
@property (nonatomic, strong) UIButton *ZGevaButton;

- (void)configWithItem:(NSDictionary *)dictionary;
@end
