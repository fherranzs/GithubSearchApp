//
//  UserDetailsViewModel.m
//  GithubSearchApp
//
//  Created by Francisco Herranz on 01/03/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import "UserDetailsViewModel.h"
#import "CoreDataHelper.h"
#import "Utils.h"

@implementation UserDetailsViewModel

- (instancetype)initViewModelWithUserDictionary:(NSDictionary *)userDictionary
{
    self = [super init];
    if (self)
    {
        self.selectedUserDictionary = userDictionary;
        User *user = [[User alloc] initWithUserInformation:userDictionary andUserImage:[userDictionary objectForKey:@"avatar"]];
        self.selectedUser = user;
        [self saveUserDetails:user];
    }
    return self;
}

- (instancetype)initViewModelWithUser:(User *)user
{
    self = [super init];
    if (self)
    {
        self.selectedUser = user;
        [self saveUserDetails:user];
    }
    return self;
}

#pragma mark -Download followers, following and repositories methods-
- (void)downloadUserAssets
{
    [self downloadFollowing];
    [self downloadFollowers];
    [self downloadRepositories];
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_DETAILS_UPDATE object:nil];
}

- (void)downloadFollowers
{
    NSURL *url = [NSURL URLWithString:self.selectedUser.followersURL];
    NSError *error;
    NSData *urlData = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    NSArray *followersInformationArray = [NSJSONSerialization JSONObjectWithData:urlData
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&error];
    NSLog(@"Downloaded data: %@", followersInformationArray);
    self.followersArray = [[NSMutableArray alloc] init];
    for (NSDictionary *follower in followersInformationArray)
    {
        [self.followersArray addObject:[follower objectForKey:LOGIN]];
    }
    self.followersLabel = [NSString stringWithFormat:@"Followers: %lu", (unsigned long)followersInformationArray.count];
}

- (void)downloadRepositories
{
    NSURL *url = [NSURL URLWithString:_selectedUser.reposURL];
    NSError *error;
    NSData *urlData = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    NSArray *reposInformationArray = [NSJSONSerialization JSONObjectWithData:urlData
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&error];
    NSLog(@"Downloaded data: %@", reposInformationArray);
    self.repositoriesArray = [[NSMutableArray alloc] init];
    for (NSDictionary *repo in reposInformationArray)
    {
        [self.repositoriesArray addObject:[repo objectForKey:@"name"]];
    }
    self.repositoriesLabel = [NSString stringWithFormat:@"Repositories: %lu", (unsigned long)reposInformationArray.count];
}

- (void)downloadFollowing
{
    NSMutableString *urlString = [NSMutableString stringWithString:self.selectedUser.followingURL];
    NSURL *url = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@"{/other_user}" withString:@""]];
    NSError *error;
    NSData *urlData = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    NSArray *followingArray = [NSJSONSerialization JSONObjectWithData:urlData
                                                              options:NSJSONReadingAllowFragments
                                                                error:&error];
    NSLog(@"Downloaded data: %@", followingArray);
    self.followingLabel = [NSString stringWithFormat:@"Following: %lu", (unsigned long)followingArray.count];
}

#pragma mark -Persistent storage methods-
- (void)saveUserDetails:(User *)user
{
    NSData *imageBinaryData = UIImageJPEGRepresentation(user.userAvatar, 0.0);
    [[CoreDataHelper sharedInstance] saveUserDetails:user withImageData:imageBinaryData];
}

@end
