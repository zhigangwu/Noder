//
//  NewPageTableViewController.h
//  Noder
//
//  Created by Mac on 2017/8/31.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPageTableViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIView *choseView;
@property (nonatomic, strong) UIButton *choseButton;
@property (nonatomic, strong) UILabel *choseLabel;
@property (nonatomic, strong) UIImageView *imageview;

@property (nonatomic, strong) UITextView *TitleView;
@property (nonatomic, strong) UITextView *ContentView;

@property (nonatomic, strong) UILabel *pickLabel;
@property (nonatomic, strong) NSArray *array;



@end
