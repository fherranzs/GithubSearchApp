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
    _userDetailsViewModel = [[UserDetailsViewModel alloc] initViewModelWithUser:_selectedUser];
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
    [_userDetailsViewModel downloadUserAssets];
}

- (void)viewUpdateReceived
{
    _userDetailsLabel.text = _userDetailsViewModel.selectedUser.username;
    _usernameLabel.text = [NSString stringWithFormat:@"Username: %@", _userDetailsViewModel.selectedUser.username];
    _followersLabel.text = _userDetailsViewModel.followersLabel;
    _followingLabel.text = _userDetailsViewModel.followingLabel;
    _repositoriesLabel.text = _userDetailsViewModel.repositoriesLabel;
    repositoriesArray = _userDetailsViewModel.repositoriesArray;
    followersArray = _userDetailsViewModel.followersArray;
    
    _userAvatarImageView.image = _userDetailsViewModel.selectedUser.userAvatar;
    _userAvatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect frame = _userAvatarImageView.frame;
    frame.size = _userAvatarImageView.image.size;
    _userAvatarImageView.frame = frame;
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
