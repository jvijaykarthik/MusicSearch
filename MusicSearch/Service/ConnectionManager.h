//
//  ConnectionManager.h
//  MusicSearch
//
//  Created by Vijay Karthik on 11/19/16.
//  Copyright © 2016 Vijay Karthik Jeyaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongTrack.h"

@interface ConnectionManager : NSObject

+ (id)sharedManager;
- (void)searchForSongTrack:(NSString*)name withCompletionHandler:(void (^)(NSMutableArray *))completionHandler;
- (void)getImageForAlbumURL:(NSString*)strAlbumURL withCompletionHandler:(void (^)(NSData *))completionHandler;
- (void)getSongLyrics:(SongTrack*)objSongTrack withCompletionHandler:(void (^)(NSString *))completionHandler;

@end
