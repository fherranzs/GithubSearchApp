//
//  APIWorker.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 29/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import "Foundation/Foundation.h"

@interface APIWorker : NSObject<NSURLSessionDelegate>

+ (APIWorker *)sharedInstance;

- (void) searchUserswithUsername:(NSString *)username onSuccess:(void (^)(NSData *aData, NSURLResponse *response))success  onFailure : (void(^)(NSError *error))failure;

@end
