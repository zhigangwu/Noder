//
//  UIViewController+add.m
//  Noder
//
//  Created by 吴志刚 on 2017/11/18.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "UIViewController+add.h"

@implementation UIViewController (add)

- (void)wzgpush:(UIViewController *)viewcontroller{
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

@end
