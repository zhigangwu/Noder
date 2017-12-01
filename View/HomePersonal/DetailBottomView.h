//
//  DetailButtomView.h
//  Noder
//
//  Created by 吴志刚 on 28/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackViewDelegate <NSObject>

- (void)backview:(UIButton *)sender;

@end

@protocol commentDelegate <NSObject>

- (void)commentButton:(UIButton *)sender;

@end

@protocol comCenterDelegate <NSObject>

- (void)comCenterButton:(UIButton *)sender;

@end


@interface DetailBottomView : UIView

@property (nonatomic, weak) id<BackViewDelegate> backdelegate;
@property (nonatomic, weak) id<commentDelegate> commentdelegate;
@property (nonatomic, weak) id<comCenterDelegate> comCenterDelegate;

- (instancetype)init;

@end
