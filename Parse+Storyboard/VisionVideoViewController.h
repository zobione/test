//
//  VisionVideoViewController.h
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 23/02/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface VisionVideoViewController : UIViewController

- (IBAction)playMovie:(id)sender;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;


@end
