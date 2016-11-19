//
//  SongCell.h
//  MusicSearch
//
//  Created by Vijay Karthik on 11/19/16.
//  Copyright © 2016 Vijay Karthik Jeyaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongCell : UITableViewCell

#pragma mark - Properties

@property (nonatomic, weak) IBOutlet UILabel *lblSongName;
@property (nonatomic, weak) IBOutlet UILabel *lblArtistName;
@property (nonatomic, weak) IBOutlet UILabel *lblAlbumName;
@property (nonatomic, weak) IBOutlet UIImageView *imgAlbum;

@end
