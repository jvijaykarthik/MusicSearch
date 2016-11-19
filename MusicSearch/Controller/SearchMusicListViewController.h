//
//  SearchMusicListViewController.h
//  MusicSearch
//
//  Created by Vijay Karthik on 11/19/16.
//  Copyright © 2016 Vijay Karthik Jeyaraj. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface SearchMusicListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

#pragma mark - Properties

@property (nonatomic, weak) IBOutlet UITextField *txtSearchKey;
@property (nonatomic, weak) IBOutlet UIButton *btnSearch;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
