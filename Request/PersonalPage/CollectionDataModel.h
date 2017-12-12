//
//  CollectionDataModel.h
//  Noder
//
//  Created by 吴志刚 on 22/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <Mantle/Mantle.h>

@class CollectionAuthor;

@interface CollectionDataModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *author_id;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *id;
@property (nonatomic ,strong) CollectionAuthor *author;

@end

@interface CollectionAuthor : MTLModel <MTLJSONSerializing>

@property (nonatomic ,strong) NSURL *avatar_url;

@end


