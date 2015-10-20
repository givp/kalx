//
//  playlistViewController.m
//  kalxfm
//
//  Created by Giv Parvaneh on 10/19/15.
//  Copyright © 2015 Giv Parvaneh. All rights reserved.
//

#import "playlistViewController.h"

#define PLAYLIST_URL @"http://kalx.berkeley.edu/apps/playlists"

@implementation playlistViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: PLAYLIST_URL] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 100];
    
    [self.webView loadRequest: request];
}

- (IBAction)closeTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
