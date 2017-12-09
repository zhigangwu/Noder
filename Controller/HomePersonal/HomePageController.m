//
//  HomePageController.m
//  Noder
//
//  Created by alienware on 2017/6/4.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "HomePageController.h"

#import "AllViewController.h"
#import "EssenceViewController.h"
#import "ShareViewController.h"
#import "QandAViewController.h"
#import "RecruitmentViewController.h"
#import "DevTableViewController.h"
#import "UIColor+textColor.h"

#import "Masonry.h"
#import "UIFont+SetFont.h"

@interface HomePageController ()

@property (nonatomic ,strong) NSArray *titleData;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation HomePageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    UIFont *font = [UIFont ZGFontA];
    NSDictionary *dictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName: [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]};
    self.navigationController.navigationBar.titleTextAttributes = dictionary;

    CALayer *layer = [self.menuView layer];
    [layer setShadowOpacity:0];
    [layer setBorderWidth:0.5];
    [layer setBorderColor:[[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1/1.0] CGColor]];
}

- (NSArray *)titleData{
    
    if (!_titleData) {
        _titleData = @[@"全部",@"精华",@"分享",@"问答",@"招聘",@"测试"];
    }
    return _titleData;
}

- (instancetype)init{
    if (self = [super init]) {
        self.titleSizeNormal = 14;
        self.titleSizeSelected = 14;
        self.titleFontName = @"PingFangSC-Medium";
        self.titleColorNormal = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1/1.0];;
        self.titleColorSelected = [UIColor textColor];
        self.progressColor = [UIColor textColor];
        self.progressWidth = 28;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
     }

    return self;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titleData.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titleData[index];
}



- (__kindof UIViewController * _Nonnull)pageController:(WMPageController * _Nonnull)pageController viewControllerAtIndex:(NSInteger)index{
    
    switch (index) {
        case 0:{
            AllViewController *all = [[AllViewController alloc] init];
            all.title = @"1";
            
            return all;
        }
            break;
        
        case 1:{
            EssenceViewController *essence = [[EssenceViewController alloc] init];
            essence.title = @"2";
            
            return essence;
        }
            break;
        
        case 2:{
            ShareViewController *share = [[ShareViewController alloc] init];
            share.title = @"3";
            
            return share;
        }
            break;
         
        case 3:{
            QandAViewController *QandA = [[QandAViewController alloc] init];
            QandA.title = @"4";
            
            return QandA;
        }
            break;
            
        case 4:{
            RecruitmentViewController *recr = [[RecruitmentViewController alloc] init];
            recr.title = @"5";
            
            return recr;
        }
            break;
            
        default:{
            DevTableViewController *dev = [[DevTableViewController alloc] init];
            dev.title = @"5";
            
            return dev;
        }
            break;
            
    }
    
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView
{
    return CGRectMake(0, 64, self.view.frame.size.width, 44);
}


















@end
