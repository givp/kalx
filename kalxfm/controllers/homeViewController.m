//
//  homeViewController.m
//  kalxfm
//
//  Created by Giv Parvaneh on 10/19/15.
//  Copyright © 2015 Giv Parvaneh. All rights reserved.
//

#import "homeViewController.h"


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define STREAM_URL @"http://icecast.media.berkeley.edu:8000/kalx-128.mp3"
//#define STREAM_URL @"http://stream.radiojavan.com"

@implementation homeViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    
    
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Home"
                                                    subtitle:nil
                                                       image:nil
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                      }];
    
    REMenuItem *playlistItem = [[REMenuItem alloc] initWithTitle:@"Playlist"
                                                       subtitle:nil
                                                          image:nil
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                         }];
    
    REMenuItem *aboutItem = [[REMenuItem alloc] initWithTitle:@"About"
                                                        subtitle:nil
                                                           image:nil
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
                                                          }];
    
    
    menu = [[REMenu alloc] initWithItems:@[homeItem, playlistItem, aboutItem]];
    
    menu.backgroundColor = [UIColor whiteColor];
    menu.shadowColor = [UIColor whiteColor];
    menu.textShadowColor = [UIColor whiteColor];
    menu.liveBlur = YES;
    menu.subtitleTextShadowColor = [UIColor whiteColor];
    menu.separatorColor = [UIColor whiteColor];
    menu.borderWidth = 0.0;
    menu.highlightedBackgroundColor = RGBCOLOR(0, 106, 57);
    menu.highlightedSeparatorColor = [UIColor whiteColor];
    menu.highlightedTextShadowColor = RGBCOLOR(0, 106, 57);
    menu.highlightedTextColor = [UIColor whiteColor];
    
    
    _audioStream = [[FSAudioStream alloc] init];
    //[_audioStream setUrl:[NSURL URLWithString:STREAM_URL]];
    [_audioStream playFromURL:[NSURL URLWithString:STREAM_URL]];
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    playing = NO;
    
     //__weak homeViewController *weakSelf = self;
    _audioStream.onMetaDataAvailable = ^(NSDictionary *metaData) {
        
        NSLog(@"STREAM: %@", [metaData objectForKey:@"StreamTitle"]);
        //weakSelf.currentSongLabel.text = [metaData objectForKey:@"StreamTitle"];
    };

}
- (IBAction)menuTapped:(id)sender {
    
    if (menu.isOpen) {
        return [menu close];
    }
    
    [menu showFromNavigationController:self.navigationController];
}

- (IBAction)playTapped:(id)sender {
    
    if (playing) {
        NSLog(@"Stop");
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
        [_audioStream pause];
        playing = NO;
        
    } else {
    
        NSLog(@"Play");
        [self.playButton setTitle:@"Stop" forState:UIControlStateNormal];
        [_audioStream pause];
        playing = YES;
    }

}

#pragma mark - audio delegates


@end
