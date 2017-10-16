//
//  MMJDIYHeader.h
//  Noder
//
//  Created by Mac on 2017/10/16.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface MMJDIYHeader : MJRefreshHeader

- (void)prepare NS_REQUIRES_SUPER;

- (void)placeSubviews NS_REQUIRES_SUPER;

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

@end
