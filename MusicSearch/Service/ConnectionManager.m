//
//  ConnectionManager.m
//  MusicSearch
//
//  Created by Vijay Karthik on 11/19/16.
//  Copyright © 2016 Vijay Karthik Jeyaraj. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager

+ (id)sharedManager {
    static ConnectionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return  manager;
}

- (id)init {
    self = [super init];
    return self;
}

//Method to get the search results
- (void)searchForSongTrack:(NSString*)searchKey withCompletionHandler:(void (^)(NSMutableArray *))completionHandler {
    
    NSURL *url = [self formURLWithSearchKey:searchKey];
    
    [self getDataForURL:url withCompletionHandler:^(NSData *data){
        
        NSMutableArray *retArray = nil;
        NSError *error;
        if (data != nil) {
            NSMutableDictionary *dataDic = (NSMutableDictionary*)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error != nil) {
                NSLog(@"Error Description %@", [error description]);
            }
            else {
                retArray = [[NSMutableArray alloc] init];
                
                NSArray *dataArray = [dataDic objectForKey:@"results"];
                
                for (int nTemp = 0; nTemp < [dataArray count]; nTemp++) {
                    NSDictionary *dic = (NSDictionary*)[dataArray objectAtIndex:nTemp];
                    
                    if (dic != nil) {
                        SongTrack *loc = [[SongTrack alloc] initWithDictionary:dic];
                        [retArray addObject:loc];
                    }
                }
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(retArray);
        }];
    }];
}

//Method to get the image for album
- (void)getImageForAlbumURL:(NSString*)strAlbumURL withCompletionHandler:(void (^)(NSData *))completionHandler {
    NSURL *url = [NSURL URLWithString:strAlbumURL];
    
    [self getDataForURL:url withCompletionHandler:^(NSData *data){
        
        NSData *retData = nil;
        NSError *error;
        if (data != nil) {
            if (error != nil) {
                NSLog(@"Error Description %@", [error description]);
            }
            else {
                retData = data;
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(retData);
        }];
    }];
}

//Method to get the song lyrics
- (void)getSongLyrics:(SongTrack*)objSongTrack withCompletionHandler:(void (^)(NSString *))completionHandler {
    
    NSURL *url = [self formURLWithSongTrack:objSongTrack];
    
    [self getDataForURL:url withCompletionHandler:^(NSData *data){
        
        NSString *retString = nil;
        NSError *error;
        if (data != nil) {
            if (error != nil) {
                NSLog(@"Error Description %@", [error description]);
            }
            else {
                NSData *dataDic = (NSData*)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                retString = [NSString stringWith data;
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(retString);
        }];
    }];
}

#pragma mark - Main Service call

- (void)getDataForURL:(NSURL*)url withCompletionHandler:(void (^)(NSData *))completionHandler {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            NSLog(@"Error Description %@",[error description]);
        }
        else {
            NSInteger httpStatusCode = [(NSHTTPURLResponse*)response statusCode];
            
            if (httpStatusCode != 200) {
                NSLog(@"HTTP Code %ld",(long)httpStatusCode);
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(data);
            }];
        }
    }];
    
    [task resume];
    
}

#pragma mark - Helper Methods

- (NSURL*)formURLWithSearchKey:(NSString*)searchKey {
    NSString *strURL = (NSString*)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"searchUrl"];
    
    strURL = [strURL stringByAppendingString:[searchKey stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    return [NSURL URLWithString:strURL];
}

- (NSURL*)formURLWithSongTrack:(SongTrack*)objSongTrack {
    NSString *strURL = (NSString*)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"lyricsUrl"];
    
    NSString *strConstruct = [NSString stringWithFormat:strURL,objSongTrack.strArtistName,objSongTrack.strSongName];
    NSURL *urlReturn = [NSURL URLWithString:strConstruct];
    return urlReturn;
}

@end
