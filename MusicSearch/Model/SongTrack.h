//
//  SongTrack.h
//  MusicSearch
//
//  Created by Vijay Karthik on 11/19/16.
//  Copyright © 2016 Vijay Karthik Jeyaraj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongTrack : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

#pragma mark - Properties

@property (nonatomic, copy) NSString *strArtistName;
@property (nonatomic, copy) NSString *strSongName;
@property (nonatomic, copy) NSString *strAlbumName;
@property (nonatomic, copy) NSString *strAlbumImageURL;
@property (nonatomic, copy) NSString *strAlbumDetailImageURL;

@end
