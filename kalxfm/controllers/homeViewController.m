//
//  homeViewController.m
//  kalxfm
//
//  Created by Giv Parvaneh on 10/19/15.
//  Copyright © 2015 Giv Parvaneh. All rights reserved.
//

#import "homeViewController.h"

#define STREAM_URL @"http://icecast.media.berkeley.edu:8000/kalx-128.mp3"
//#define STREAM_URL @"http://stream.radiojavan.com"

@implementation homeViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    
    _audioStream = [[FSAudioStream alloc] init];
    [_audioStream playFromURL:[NSURL URLWithString:STREAM_URL]];
    [self.playButton setTitle:@"Stop" forState:UIControlStateNormal];
    playing = YES;
    
     //__weak homeViewController *weakSelf = self;
    _audioStream.onMetaDataAvailable = ^(NSDictionary *metaData) {
        
        NSLog(@"STREAM: %@", [metaData objectForKey:@"StreamTitle"]);
        //weakSelf.currentSongLabel.text = [metaData objectForKey:@"StreamTitle"];
    };

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
