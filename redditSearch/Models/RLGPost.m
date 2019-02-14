//
//  RLGPost.m
//  redditSearch
//
//  Created by RYAN GREENBURG on 2/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import "RLGPost.h"

@implementation RLGPost

- (instancetype)initWithPost:(NSString *)title upvotes:(NSInteger)upvotes comments:(NSInteger)comments imageURL:(nonnull NSString *)imageURL
{
    self = [super init];
    if (self)
    {
        _title = title;
        _upvotes = upvotes;
        _comments = comments;
        _imageURL = imageURL;
    }
    return self;
}

@end

@implementation RLGPost (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSInteger upvotes = [dictionary[@"ups"] integerValue];
    NSInteger comments = [dictionary[@"num_comments"] integerValue];
    NSString *imageURL = dictionary[@"url"];
    
    if (![title isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    return  [self initWithPost:title upvotes:upvotes comments:comments imageURL:imageURL];
}

@end
