//
//  UserSearchViewModel.m
//  GithubSearchApp
//
//  Created by Francisco Herranz on 01/03/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import "UserSearchViewModel.h"
#import "UserModel.h"
#import "Utils.h"
#import "APIWorker.h"

@implementation UserSearchViewModel

@synthesize usersFoundInformation;

- (instancetype) initViewModel
{
    self = [super init];
    if (self)
    {
        NSDictionary *noUsersInfo = [[NSDictionary alloc] initWithObjectsAndKeys:NO_USERS, LOGIN, nil];
        User *noUsers = [[User alloc] initWithUserInformation:noUsersInfo andUserImage:[UIImage imageNamed:@"githubImage"]];
        self.usersFoundInformation = [[NSMutableArray alloc] initWithObjects:noUsers, nil];
    }
    return self;
}

- (void)startSearchWithUsername:(NSString *)username
{
    NSLog(@"Start search in view model with username: %@", username);
    [[APIWorker sharedInstance] searchUserswithUsername:username onSuccess:^(NSData *aData, NSURLResponse *response) {
        NSLog(@"Success");
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:nil];
        NSArray *usersInformation = [[NSArray alloc] init];
        usersInformation = [responseDict objectForKey:@"items"];
        if (usersInformation.count > 0)
        {
            [self->usersFoundInformation removeAllObjects];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSDictionary *userInformation in usersInformation)
            {
                NSURL *url = [NSURL URLWithString:[userInformation objectForKey:AVATAR]];
                NSData *data = [NSData dataWithContentsOfURL:url];
                User *newUser = [[User alloc] initWithUserInformation:userInformation andUserImage:[UIImage imageWithData:data]];
                [self->usersFoundInformation addObject:newUser];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_SEARCH_UPDATE object:nil];
        });
    } onFailure:^(NSError *error) {
        NSLog(@"Failure");
    }];
}

@end
