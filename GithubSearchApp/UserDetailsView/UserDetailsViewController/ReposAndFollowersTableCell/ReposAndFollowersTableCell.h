//
//  ReposAndFollowersTableCell.h
//  GithubSearchApp
//
//  Created by Francisco Herranz on 29/02/2020.
//  Copyright © 2020 Francisco Herranz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReposAndFollowersTableCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UITableView *contentTableView;
@property (strong, nonatomic) NSArray *dataArray;

@end
