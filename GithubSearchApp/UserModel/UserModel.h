//
//  UserModel.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 29/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject

- (instancetype) initWithUserInformation:(NSDictionary *)userInformation andUserImage:(UIImage *)userImage;

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) UIImage *userAvatar;
@property (strong, nonatomic) NSString *followersURL;
@property (strong, nonatomic) NSString *followingURL;
@property (strong, nonatomic) NSString *reposURL;

@end
