//
//  RLGPost.h
//  redditSearch
//
//  Created by RYAN GREENBURG on 2/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RLGPost : NSObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSInteger upvotes;
@property (nonatomic, readonly) NSInteger comments;
@property (nonatomic, readonly) NSString *imageURL;

- (instancetype)initWithPost:(NSString *)title
                     upvotes:(NSInteger)upvotes
                    comments:(NSInteger)comments
                       imageURL:(NSString *)imageURL;

@end

@interface RLGPost (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
