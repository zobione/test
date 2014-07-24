//
//  HomeViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 15/04/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AdColony/AdColony.h>

@interface HomeViewController : UIViewController <AdColonyAdDelegate>
{
    NSTimer *levelTimer;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)Play:(id)sender;
-(IBAction)triggerVideo;
@property (nonatomic, retain) NSString * URLVideo;
@property (nonatomic, retain) NSString * Producteur;
@property (nonatomic, retain) NSString * Description;
@property (nonatomic, retain) PFObject *Video;
@property (nonatomic, retain) PFObject *Asso;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@property (weak, nonatomic) IBOutlet UILabel *Ligne1;
@property (weak, nonatomic) IBOutlet UILabel *Ligne2;
@property (weak, nonatomic) IBOutlet UILabel *Ligne3;
@property (weak, nonatomic) IBOutlet UIButton *BouttonPub;
@property (weak, nonatomic) IBOutlet UIButton *BouttonPrincipal;

@property (nonatomic) NSArray *pickValue;
@property (nonatomic) NSString *assoNomQuery;

- (void)levelTimerCallback:(NSTimer *)timer;

@end
