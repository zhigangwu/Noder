//
//  NewPageView.h
//  Noder
//
//  Created by 吴志刚 on 09/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPageView : UIView

@property (nonatomic, strong) UIView *choseView;
@property (nonatomic, strong) UIButton *choseButton;
@property (nonatomic, strong) UILabel *choseLabel;
@property (nonatomic, strong) UIImageView *imageview;

@property (nonatomic, strong) UITextView *TitleView;
@property (nonatomic, strong) UITextView *ContentView;

@property (nonatomic, strong) UILabel *pickLabel;

- (instancetype)init;

@end
