//
//  UserDetailsViewModel.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 01/03/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserDetailsViewModel : NSObject

@property (strong, nonatomic) NSMutableArray *repositoriesArray;
@property (strong, nonatomic) NSMutableArray *followersArray;
@property (strong, nonatomic) User *selectedUser;
@property (strong, nonatomic) NSString *repositoriesLabel;
@property (strong, nonatomic) NSString *followersLabel;
@property (strong, nonatomic) NSString *followingLabel;

- (instancetype)initViewModelWithUser:(User *)user;

- (void)downloadUserAssets;

@end
