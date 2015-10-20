//
//  playlistViewController.h
//  kalxfm
//
//  Created by Giv Parvaneh on 10/19/15.
//  Copyright © 2015 Giv Parvaneh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface playlistViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
