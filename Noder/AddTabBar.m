//
//  AddTabBar.m
//  Noder
//
//  Created by Mac on 2017/9/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "AddTabBar.h"
#import "ControllerManager.h"
#import "Masonry.h"
#import "MenuViewController.h"

static NSString * const AddTabBarClick  = @"AddTabBarClick";

@implementation AddTabBar

- (UIButton *)plusButton
{

        if (_plusButton == nil) {
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            [but addTarget:self action:@selector(menuPage:) forControlEvents:UIControlEventTouchUpInside];
            [but setImage:[UIImage imageNamed:@"Group-2"] forState:UIControlStateNormal];
            [but sizeToFit];
            
            _plusButton = but;
            
            [self addSubview:_plusButton];
        }

    return _plusButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;

    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
}

- (void)menuPage:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:AddTabBarClick object:self];
    
//    NSDictionary *dictionary = [ControllerManager shareManager].dictionary;
//    NSString *string = dictionary[@"success"];
//    if (string.boolValue == true ){
    
//    MenuViewController *menuViewController = [[MenuViewController alloc] init];
//    [self.window addSubview:menuViewController.view];
    


//    }
}



@end
