//
//  SearchMusicListViewController.m
//  MusicSearch
//
//  Created by Vijay Karthik on 11/19/16.
//  Copyright © 2016 Vijay Karthik Jeyaraj. All rights reserved.
//

#import "SearchMusicListViewController.h"
#import "MusicDetailViewController.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "ConnectionManager.h"
#import "SongCell.h"
#import "SongTrack.h"

@interface SearchMusicListViewController ()

@end

@implementation SearchMusicListViewController {
    NSMutableArray *arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Configuring the tableview
- (void)configureTableView {
    [[self tableView] setHidden:YES];
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    [[self tableView] setRowHeight:UITableViewAutomaticDimension];
    [[self tableView] setEstimatedRowHeight:80.0];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [[self tableView] setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (IBAction)searchMusic:(id)sender {
    [[self tableView] setHidden:YES];
//    Show alert if the user has not entered any text
    
    NSString *strSearchKey = [self txtSearchKey].text;
    strSearchKey = [strSearchKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([strSearchKey isEqualToString:@""]) {
        [self showAlert:@"Please enter a valid string"];
        [self txtSearchKey].text = @"";
    } else {
        [self loadTableWithSearchKey:strSearchKey];
    }
}

#pragma mark - Helper Method for loading TableView

- (void)loadTableWithSearchKey:(NSString*)strSearchKey
{
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
//    Check if the network is reachable, if not show alert
    if (status != NotReachable)
    {
        // Show progress bar still we receive the data from service
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self view] animated:YES];
        [hud setLabelText:@"Loading...."];
        
        [[ConnectionManager sharedManager] searchForSongTrack:strSearchKey withCompletionHandler:^(NSMutableArray *arrList){
            if (arrList != nil) {
                
                [[self tableView] setHidden:NO];
                
                //  Store received data in local ref
                arrData = [arrList mutableCopy];
                
                //  Reload the TableView
                [[self tableView] reloadData];
                
            } else {
                [self showAlert:@"Sorry, didn't receive any data."];
            }
            // Hide the progress bar as soon as we receive the data from service
            [hud hide:YES];
        }];
    }
    else
    {
        [self showAlert:@"Please check your Internet connectivity and try again."];
    }
}

# pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrData count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell"];
    if (cell == nil) {
        cell = [[SongCell alloc] init];
    }
    cell.imgAlbum.image = nil;
    
    SongTrack *songData = (SongTrack*)[arrData objectAtIndex:[indexPath row]];
    [[cell lblSongName] setText:[NSString stringWithFormat:@"Track: %@",[songData strSongName]]];
    [[cell lblArtistName] setText:[NSString stringWithFormat:@"Artist: %@",[songData strArtistName]]];
    [[cell lblAlbumName] setText:[NSString stringWithFormat:@"Album: %@",[songData strAlbumName]]];

//    Loading image async
    [[ConnectionManager sharedManager] getImageForAlbumURL:[songData strAlbumImageURL] withCompletionHandler:^(NSData * data) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    SongCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.imgAlbum.image = image;
                });
            }
        }

    }];
    
    return cell;
}

# pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTrack *locData = (SongTrack*)[arrData objectAtIndex:[indexPath row]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    MusicDetailViewController *musicDetailViewController = (MusicDetailViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MusicDetail"];
    [musicDetailViewController setSongTrackInfo:locData];
    [[self navigationController] pushViewController:musicDetailViewController animated:YES];
}

# pragma mark - Show Alert Helper message
-(void)showAlert:(NSString*)strMessage
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Music Search"
                                          message:strMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Okay", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
