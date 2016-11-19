//
//  SongTrack.m
//  MusicSearch
//
//  Created by Vijay Karthik on 11/19/16.
//  Copyright © 2016 Vijay Karthik Jeyaraj. All rights reserved.
//

#import "SongTrack.h"

@implementation SongTrack

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        self.strSongName = dictionary[@"trackName"] != nil ? dictionary[@"trackName"] : @"";
        self.strAlbumName = dictionary[@"collectionName"] != nil ? dictionary[@"collectionName"] : @"";
        self.strArtistName = dictionary[@"artistName"] != nil ? dictionary[@"artistName"] : @"";
        self.strAlbumImageURL = dictionary[@"artworkUrl30"] != nil ? dictionary[@"artworkUrl30"] : @"";
        self.strAlbumDetailImageURL = dictionary[@"artworkUrl100"] != nil ? dictionary[@"artworkUrl100"] : @"";
    }
    return self;
}

@end
