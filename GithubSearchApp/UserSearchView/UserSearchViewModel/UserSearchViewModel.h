//
//  UserSearchViewModel.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 01/03/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserSearchViewModel : NSObject

@property (strong, nonatomic) NSMutableArray *usersFoundInformation;

- (instancetype) initViewModel;
- (void)startSearchWithUsername:(NSString *)username;


@end
