//
//  CoreDataHelper.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 01/03/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"
#import "UserDetails+CoreDataClass.h"
#import "UserModel.h"

@interface CoreDataHelper : CoreDataManager

+ (CoreDataHelper *)sharedInstance;
- (void)saveUserDetails:(User *)user withImageData:(NSData *)imageData;

@end
