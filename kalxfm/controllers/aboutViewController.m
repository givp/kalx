//
//  aboutViewController.m
//  kalxfm
//
//  Created by Giv Parvaneh on 11/1/15.
//  Copyright © 2015 Giv Parvaneh. All rights reserved.
//

#import "aboutViewController.h"

@implementation aboutViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // GA
    NSString *name = @"About";
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (IBAction)closeTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
