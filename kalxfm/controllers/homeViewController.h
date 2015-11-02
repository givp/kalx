//
//  homeViewController.h
//  kalxfm
//
//  Created by Giv Parvaneh on 10/19/15.
//  Copyright © 2015 Giv Parvaneh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSAudioStream.h"
#import <Google/Analytics.h>

@interface homeViewController : UIViewController {
    FSAudioStream *_audioStream;
}

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
