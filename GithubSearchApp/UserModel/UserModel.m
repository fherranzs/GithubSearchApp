//
//  UserModel.m
//  GithubSearchApp
//
//  Created by Francisco Herranz on 29/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import "UserModel.h"
#import "Utils.h"

@implementation User

- (instancetype) initWithUserInformation:(NSDictionary *)userInformation andUserImage:(UIImage *)userImage
{
    self = [super init];
    if (self)
    {
        if ([userInformation objectForKey:LOGIN])
        {
            self.username = [userInformation objectForKey:LOGIN];
        }
        if ([userInformation objectForKey:FOLLOWERS])
        {
            self.followersURL = [userInformation objectForKey:FOLLOWERS];
        }
        if ([userInformation objectForKey:FOLLOWING])
        {
            self.followingURL = [userInformation objectForKey:FOLLOWING];
        }
        if ([userInformation objectForKey:REPOS])
        {
            self.reposURL = [userInformation objectForKey:REPOS];
        }
        if (userImage)
        {
            self.userAvatar = userImage;
        }
    }
    return self;
}

@end
