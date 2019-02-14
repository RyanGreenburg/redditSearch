//
//  RLGPostController.m
//  redditSearch
//
//  Created by RYAN GREENBURG on 2/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import "RLGPostController.h"

static NSString *const baseURLString = @"https://www.reddit.com/r";

@implementation RLGPostController

+ (RLGPostController *)sharedInstance
{
    static RLGPostController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RLGPostController new];
    });
    return sharedInstance;
}

+ (void)fetchPostsForSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<RLGPost *> * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:baseURLString];
    NSURL *searchURL = [url URLByAppendingPathComponent:searchTerm];
    NSURL *finalURL = [searchURL URLByAppendingPathExtension:@"json"];
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            // Access top level dictionary
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (!topLevelDictionary || ![topLevelDictionary isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"Error parsing JSON %@", error);
                completion(nil);
                return;
            }
            // step into next level
            NSDictionary *postDataDictionary = topLevelDictionary[@"data"];
            // step into next level
            NSArray *childrenArray = postDataDictionary[@"children"];
            // create placeholder array
            NSMutableArray *postArray = [NSMutableArray new];
            // iterate through array
            for (NSDictionary *dictionary in childrenArray)
            {
                NSDictionary *data = dictionary[@"data"];
                RLGPost *post = [[RLGPost alloc] initWithDictionary:data];
                // Add post to array
                [postArray addObject:post];
            }
            completion(postArray);
        }
    }] resume];
}

+ (void) fetchImageForPost:(RLGPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:post.imageURL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        UIImage *postImage = [UIImage imageWithData:data];
        completion(postImage);
    }] resume];
}

@end
