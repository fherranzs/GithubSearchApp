//
//  APIWorker.m
//  GithubSearchApp
//
//  Created by Francisco Herranz on 29/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import "APIWorker.h"
#import "Utils.h"

@implementation APIWorker

+ (APIWorker *)sharedInstance
{
    static dispatch_once_t once;
    static id apiWorker;
    dispatch_once(&once, ^{
        apiWorker = [[APIWorker alloc]init];
    });
    return  apiWorker;
}

- (void) searchUserswithUsername:(NSString *)username onSuccess:(void (^)(NSData *aData, NSURLResponse *response))success  onFailure : (void(^)(NSError *error))failure
{
    NSString *requestUrlString = [NSString stringWithFormat:@"%@%@?q=%@", GITHUB_ENDPOINT, USER_SEARCH_ENDPOINT, username];
    NSLog(@"Request URL: %@", requestUrlString);
    NSURL *url = [NSURL URLWithString:requestUrlString];
    if (url == nil)
    {
        url = [NSURL URLWithString:[requestUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
    [request setValue:@"application/vnd.github.v3+json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"GET"];
    NSLog(@"Request: %@", requestUrlString);
    [self callAPI:request onSuccess:success onFailure:failure];
    
}

- (void) callAPI:(NSMutableURLRequest *)request onSuccess:(void (^)(NSData *aData, NSURLResponse *response))success  onFailure : (void(^)(NSError *error))failure
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
                                              NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                              if (statusCode == 200)
                                              {
                                                  dispatch_async( dispatch_get_main_queue(), ^{
                                                      if (data)
                                                      {
                                                          NSLog(@"Response: %@", responseDict);
                                                          success(data, response);
                                                      }
                                                      else
                                                      {
                                                          failure(error);
                                                      }
                                                  });
                                              }
                                              else
                                              {
                                                  NSLog(@"Failure Response: %@", responseDict);
                                                  failure(error);
                                              }
                                          }];
    [postDataTask resume];
}

@end
