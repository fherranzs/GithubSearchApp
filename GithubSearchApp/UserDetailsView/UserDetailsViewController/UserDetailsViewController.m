//
//  UserDetailsViewController.m
//  GithubSearchApp
//
//  Created by Francisco Herranz on 29/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "ReposAndFollowersTableCell.h"
#import "Utils.h"

@implementation UserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userDetailsViewModel = [[UserDetailsViewModel alloc] initViewModelWithUser:_selectedUser];
    self.reposAndFollowersTableView.delegate = self;
    self.reposAndFollowersTableView.dataSource = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewUpdateReceived) name:USER_DETAILS_UPDATE object:nil];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.userDetailsViewModel downloadUserAssets];
}

- (void)viewUpdateReceived
{
    self.userDetailsLabel.text = self.userDetailsViewModel.selectedUser.username;
    self.usernameLabel.text = [NSString stringWithFormat:@"Username: %@", self.userDetailsViewModel.selectedUser.username];
    self.followersLabel.text = self.userDetailsViewModel.followersLabel;
    self.followingLabel.text = self.userDetailsViewModel.followingLabel;
    self.repositoriesLabel.text = self.userDetailsViewModel.repositoriesLabel;
    repositoriesArray = self.userDetailsViewModel.repositoriesArray;
    followersArray = self.userDetailsViewModel.followersArray;
    
    self.userAvatarImageView.image = self.userDetailsViewModel.selectedUser.userAvatar;
    self.userAvatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect frame = self.userAvatarImageView.frame;
    frame.size = self.userAvatarImageView.image.size;
    self.userAvatarImageView.frame = frame;    
}


#pragma mark -TableView Delegate methods-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = INFO_CELL;
    ReposAndFollowersTableCell *cell = [self.reposAndFollowersTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[ReposAndFollowersTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0)
    {
        cell.contentLabel.text = @"Repositories";
        cell.dataArray = repositoriesArray;
    }
    if (indexPath.row == 1)
    {
        cell.contentLabel.text = @"Followers";
        cell.dataArray = followersArray;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(orientation)){
        return self.reposAndFollowersTableView.frame.size.height/2;
    }
    else{
        return 300;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}


@end
