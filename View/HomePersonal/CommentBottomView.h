//
//  CommentBottomView.h
//  Noder
//
//  Created by 吴志刚 on 11/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentBottomView : UIView 

- (instancetype)init;

@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *releasseLabel;
@property (nonatomic, strong) UIButton *releaseButton;


@end
