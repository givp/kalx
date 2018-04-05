//
//  homeViewController.m
//  kalxfm
//
//  Created by Giv Parvaneh on 10/19/15.
//  Copyright © 2015 Giv Parvaneh. All rights reserved.
//

#import "homeViewController.h"
#import <MediaPlayer/MPRemoteCommand.h>
#import <MediaPlayer/MPRemoteCommandCenter.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
#import <AVFoundation/AVFoundation.h>


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

//#define STREAM_URL @"http://icecast.media.berkeley.edu:8000/kalx-128.mp3"
//#define STREAM_URL @"http://stream.kalx.berkeley.edu:8000/kalx-320.aac"
#define STREAM_URL @"http://stream.kalx.berkeley.edu:8000/kalx-256.mp3"

@implementation homeViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self setUpAudio];
    
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    [commandCenter.pauseCommand addTarget:self action:@selector(pauseFromRemote)];
    [commandCenter.playCommand addTarget:self action:@selector(playFromRemote)];

    // GA
    NSString *name = @"Home";
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void) pauseFromRemote {
    NSLog(@"Remote pause!");
    [_audioStream stop];
    
}

- (void) playFromRemote {
    NSLog(@"Remote play!");
    [_audioStream play];
    
}
     
- (void) setUpUI {
    
    //UIImage* logoImage = [UIImage imageNamed:@"logo_header.png"];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void) setUpAudio {
    _audioStream = [[FSAudioStream alloc] init];
    [_audioStream setUrl:[NSURL URLWithString:STREAM_URL]];
    //[_audioStream preload];
    [self.playButton setTitle:@"LISTEN" forState:UIControlStateNormal];
    
    __weak typeof(self) weakSelf = self;
    _audioStream.onStateChange = ^(FSAudioStreamState state) {
        NSLog(@"STATE: %u", state);
        
        if (state == 2) {
            weakSelf.statusLabel.text = @"Buffering...";
            NSDictionary *information = @{MPMediaItemPropertyTitle : @"KALX Berkeley 90.7 FM - Buffering..."};
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:information];
            
        } else {
            weakSelf.statusLabel.text = @"";
        }
        
        if (state == 3) {
            
            [weakSelf.playButton setTitle:@"Stop" forState:UIControlStateNormal];
            
            MPMediaItemArtwork *art = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"logo_art"]];
            
            NSDictionary *information = @{MPMediaItemPropertyTitle : @"KALX Berkeley 90.7 FM", MPMediaItemPropertyArtwork:art};
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:information];
            
            
        } else {
            [weakSelf.playButton setTitle:@"Listen" forState:UIControlStateNormal];
        }
        
        
    };
    
    _audioStream.onFailure = ^(FSAudioStreamError error, NSString *errorDescription) {
        weakSelf.statusLabel.text = @"💩 Error playing stream";
    };
    
    _audioStream.onMetaDataAvailable = ^(NSDictionary *metaData) {
        
        NSLog(@"STREAM: %@", [metaData objectForKey:@"StreamTitle"]);
        //weakSelf.currentSongLabel.text = [metaData objectForKey:@"StreamTitle"];
    };
}

- (void)playlistTapped {
    [self performSegueWithIdentifier:@"playlistSegue" sender:self];
}

- (void)aboutTapped {
    [self performSegueWithIdentifier:@"aboutSegue" sender:self];
}

- (IBAction)playTapped:(id)sender {
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    if ([_audioStream isPlaying]) {
        [_audioStream stop];
        
        // GA
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                              action:@"button_press"  // Event action (required)
                                                               label:@"stop"          // Event label
                                                               value:nil] build]];    // Event value
        
    } else {
        [_audioStream play];
        
        // GA        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                              action:@"button_press"  // Event action (required)
                                                               label:@"play"          // Event label
                                                               value:nil] build]];    // Event value
    }

}

#pragma mark - audio delegates


@end
