//
//  ComContentViewContrnt.h
//  Noder
//
//  Created by Mac on 2017/9/15.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComContentView.h"


@interface ComContentViewContrnt : UIViewController <backButtonDelegate,submitButtonDelegate>

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UITextView *contentView;
@property (nonatomic, strong) NSString *QRCodeString;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSString *topic_id;
@property (nonatomic, strong) NSString *reply_id;

@property (nonatomic, strong) ComContentView *comContentView;

@end
