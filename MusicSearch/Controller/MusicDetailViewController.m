//
//  MusicDetailViewController.m
//  MusicSearch
//
//  Created by Vijay Karthik on 11/19/16.
//  Copyright © 2016 Vijay Karthik Jeyaraj. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "ConnectionManager.h"

@interface MusicDetailViewController ()

@end

@implementation MusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView {
    self.navigationItem.title = @"TRACK DETAIL";
    
    [[self lblAlbumName] setText:[NSString stringWithFormat:@"Album: %@",[[self songTrackInfo] strAlbumName]]];
    [[self lblAlbumName] setNumberOfLines:0];
    [[self lblAlbumName] sizeToFit];
    
    [[self lblArtistName] setText:[NSString stringWithFormat:@"Artist: %@",[[self songTrackInfo] strArtistName]]];
    [[self lblArtistName] setNumberOfLines:0];
    [[self lblArtistName] sizeToFit];
    
    [[self lblSongName] setText:[NSString stringWithFormat:@"Track: %@",[[self songTrackInfo] strSongName]]];
    [[self lblSongName] setNumberOfLines:0];
    [[self lblSongName] sizeToFit];

    [[self lblLyrics] setHidden:YES];
    [[ConnectionManager sharedManager] getSongLyrics:[self songTrackInfo] withCompletionHandler:^(NSString *strLyrics) {
        if (strLyrics != nil) {
            [[self lblLyrics] setHidden:NO];
            [[self lblLyrics] setNumberOfLines:0];
            [[self lblLyrics] setText:[NSString stringWithFormat:@"Lyrics: %@",strLyrics]];
            [[self lblLyrics] sizeToFit];
        }
    }];
    
    [[ConnectionManager sharedManager] getImageForAlbumURL:[[self songTrackInfo] strAlbumDetailImageURL] withCompletionHandler:^(NSData * data) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self imgAlbum].image = image;
                });
            }
        }
        
    }];
}


@end
