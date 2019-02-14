//
//  RLGPostController.h
//  redditSearch
//
//  Created by RYAN GREENBURG on 2/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLGPost.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RLGPostController : NSObject

+(RLGPostController *)sharedInstance;

+ (void)fetchPostsForSearchTerm:(NSString *)searchTerm completion: (void(^_Nullable) (NSArray<RLGPost *> *_Nullable))completion;

+ (void)fetchImageForPost:(RLGPost *)post completion: (void (^_Nullable) (UIImage *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
