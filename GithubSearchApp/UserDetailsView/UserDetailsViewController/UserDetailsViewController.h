//
//  UserDetailsViewController.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 29/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetailsViewModel.h"

@interface UserDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *repositoriesArray;
    NSMutableArray *followersArray;
}

@property (strong, nonatomic) IBOutlet UILabel *userDetailsLabel;
@property (strong, nonatomic) IBOutlet UILabel *repositoriesLabel;
@property (strong, nonatomic) IBOutlet UILabel *followersLabel;
@property (strong, nonatomic) IBOutlet UILabel *followingLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UITableView *reposAndFollowersTableView;

@property (strong, nonatomic) UserDetailsViewModel *userDetailsViewModel;
@property (strong, nonatomic) NSDictionary *selectedUserDictionary;

@end
