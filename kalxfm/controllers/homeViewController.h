//
//  homeViewController.h
//  kalxfm
//
//  Created by Giv Parvaneh on 10/19/15.
//  Copyright © 2015 Giv Parvaneh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FSAudioStream.h"

@interface homeViewController : UIViewController {
    BOOL playing;
    FSAudioStream *_audioStream;
}

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end
