//
//  GithubSearchAppTests.m
//  GithubSearchAppTests
//
//  Created by Francisco Herranz on 29/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utils.h"
#import "UserModel.h"
#import "APIWorker.h"
#import "UserSearchViewController.h"
#import "UserDetailsViewController.h"

@interface GithubSearchAppTests : XCTestCase

@end

@implementation GithubSearchAppTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void) testUserModelCreation
{
    NSDictionary *testUserInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"newUser", LOGIN, nil];
    User *noUsers = [[User alloc] initWithUserInformation:testUserInfo andUserImage:nil];
    
    XCTAssertNotNil(noUsers);
}

- (void) testGitHubSearchByUsername
{
    NSString *userNameToSearch = @"Greg";
    XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"Wait for API call"];
    NSArray *expectations = [[NSArray alloc] initWithObjects:exp, nil];
    [[APIWorker sharedInstance] searchUserswithUsername:userNameToSearch onSuccess:^(NSData *aData, NSURLResponse *response) {
        NSLog(@"Success");
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:nil];
        NSArray *usersInformation = [[NSArray alloc] init];
        usersInformation = [responseDict objectForKey:@"items"];
        XCTAssertGreaterThan(usersInformation.count, 0);
        [exp fulfill];
    } onFailure:^(NSError *error) {
        NSLog(@"Failure");
    }];
    [XCTWaiter waitForExpectations:expectations timeout:10.0];
}

- (void) testUserDetailsViewControllerCreation
{
    UserDetailsViewController *userDetailsViewController = [[UserDetailsViewController alloc] init];
    XCTAssertNotNil(userDetailsViewController);
}

- (void) testUserSearchViewControllerCreation
{
    UserSearchViewController *userSearchViewController = [[UserSearchViewController alloc] init];
    XCTAssertNotNil(userSearchViewController);
}

@end
