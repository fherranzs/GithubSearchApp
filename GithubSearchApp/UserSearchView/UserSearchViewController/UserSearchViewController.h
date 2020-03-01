//
//  ViewController.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 28/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetailsViewController.h"
#import "UserSearchViewModel.h"

@interface UserSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *usersTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *usernameSearchBar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UserSearchViewModel *userSearchViewModel;

@property (strong, nonatomic) NSMutableArray *usersFound;

@end

