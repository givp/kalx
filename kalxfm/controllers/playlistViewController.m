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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.webView loadRequest: request];
    
    // GA
    NSString *name = @"Playlist";
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (IBAction)closeTapped:(id)sender {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
