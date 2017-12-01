//
//  ComContentView.h
//  Noder
//
//  Created by 吴志刚 on 30/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol backButtonDelegate <NSObject>

- (void)backButton:(UIButton *)sender;

@end

@protocol submitButtonDelegate <NSObject>

- (void)submitButton:(UIButton *)sender;

@end


@interface ComContentView : UIView <UITextViewDelegate>

@property (nonatomic, weak) id<backButtonDelegate> backButtonDelegate;
@property (nonatomic, weak) id<submitButtonDelegate> submitButtonDelegate;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *submitView;
- (instancetype)init;

@end
