//
//  ViewController.m
//  GithubSearchApp
//
//  Created by Francisco Herranz on 28/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import "UserSearchViewController.h"
#import "UserSearchTableCell.h"
#import "UserModel.h"
#import "Utils.h"

@interface UserSearchViewController ()

@end

@implementation UserSearchViewController

@synthesize usersFound;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userSearchViewModel = [[UserSearchViewModel alloc] initViewModel];
    usersFound = self.userSearchViewModel.usersFoundInformation;
    self.usersTableView.delegate = self;
    self.usersTableView.dataSource = self;
    self.usernameSearchBar.delegate = self;
    [self.activityIndicator stopAnimating];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewUpdateReceived) name:USER_SEARCH_UPDATE object:nil];
}


#pragma mark -View control methods-
- (void)viewUpdateReceived
{
    usersFound = self.userSearchViewModel.usersFoundInformation;
    [self.usersTableView reloadData];
    [self.activityIndicator stopAnimating];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UserDetailsViewController *userDetailsViewController = segue.destinationViewController;
    NSIndexPath *path = [self.usersTableView indexPathForSelectedRow];
    userDetailsViewController.selectedUser = [usersFound objectAtIndex:path.row];
}

- (IBAction)unwindToRoot:(UIStoryboardSegue *)unwindSegue
{
}


#pragma mark -SearchBar Delegate methods-
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"Search bar");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self.activityIndicator startAnimating];
    [self.userSearchViewModel startSearchWithUsername:self.usernameSearchBar.text];
    [searchBar resignFirstResponder];
}

#pragma mark -TableView Delegate methods-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [usersFound count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = USER_CELL;
    User *currentUserDetails = [usersFound objectAtIndex:indexPath.row];
    
    UserSearchTableCell *cell = [self.usersTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UserSearchTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.usernameLabel.text = currentUserDetails.username;
    cell.userImageView.image = currentUserDetails.userAvatar;
    cell.userImageView.contentMode = UIViewContentModeScaleAspectFit;

    CGRect frame = cell.userImageView.frame;
    frame.size = cell.userImageView.image.size;
    cell.userImageView.frame = frame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 100;
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
