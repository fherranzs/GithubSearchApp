//
//  UserSearchTableCell.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 29/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSearchTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;

@end
