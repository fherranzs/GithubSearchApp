//
//  CoreDataHelper.m
//  GithubSearchApp
//
//  Created by Francisco Herranz on 01/03/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

+(CoreDataHelper *)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc]init];
    });
    
    return sharedInstance;
}

- (void)saveUserDetails:(User *)user withImageData:(NSData *)imageData
{
    if ([self fetchUserWithUsername:user.username] != nil)
    {
        return;
    }
    else
    {
        UserDetails *userDetails = [NSEntityDescription insertNewObjectForEntityForName:@"UserDetails" inManagedObjectContext:self.managedObjectContext];
        
        if (user.username != nil)
        {
            userDetails.userName = user.username;
            userDetails.userAvatar = imageData;
            userDetails.followersURL = user.followersURL;
            userDetails.followingURL = user.followingURL;
            userDetails.reposURL = user.reposURL;
            
        }
    }
    [self save];
}

- (void)save
{
    NSError *saveError = nil;
    
    if( ![[self managedObjectContext] save:&saveError] )
    {
    }
}

- (NSArray *)fetchAllUsersDetails
{
    NSFetchRequest *request = [UserDetails fetchRequest];
    NSError *error = nil;
    NSSortDescriptor *datesortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:datesortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSArray *usernamesArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    return [usernamesArray mutableCopy];
}

- (UserDetails *)fetchUserWithUsername:(NSString *)username
{
    NSArray *savedUsers = [self fetchAllUsersDetails];
    if(savedUsers.count > 0)
    {
        for (UserDetails *userDetails in savedUsers)
        {
            if ([userDetails.userName isEqualToString:username])
            {
                return userDetails;
            }
        }
    }
    return nil;
}


@end
