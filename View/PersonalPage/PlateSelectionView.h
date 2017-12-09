//
//  PlateSelectionView.h
//  Noder
//
//  Created by 吴志刚 on 09/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlateSelectionView : UIView

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIButton *cancelButton;

- (instancetype)init;

@end
