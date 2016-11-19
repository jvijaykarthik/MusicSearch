//
//  MusicDetailViewController.h
//  MusicSearch
//
//  Created by Vijay Karthik on 11/19/16.
//  Copyright © 2016 Vijay Karthik Jeyaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongTrack.h"

@interface MusicDetailViewController : UIViewController

#pragma mark - Properties

@property (nonatomic, strong) SongTrack *songTrackInfo;
@property (nonatomic, weak) IBOutlet UILabel *lblAlbumName;
@property (nonatomic, weak) IBOutlet UILabel *lblArtistName;
@property (nonatomic, weak) IBOutlet UILabel *lblSongName;
@property (nonatomic, weak) IBOutlet UILabel *lblLyrics;
@property (nonatomic, weak) IBOutlet UIImageView *imgAlbum;

@end
