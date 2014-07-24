//
//  AccueilViewController.h
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 26/02/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AccueilViewController : UITableViewController
//Asso
@property (weak, nonatomic) IBOutlet UILabel *Association;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) PFObject *Asso;
@property (weak, nonatomic) IBOutlet UILabel *Soutient;

//Commentaire
@property (weak, nonatomic) IBOutlet UILabel *DateComment;
@property (weak, nonatomic) IBOutlet UILabel *Message;
@property (weak, nonatomic) IBOutlet UILabel *Titre;


//Video
@property (weak, nonatomic) IBOutlet UILabel *videoName;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

- (IBAction)playMovie:(id)sender;

@property (nonatomic, retain) NSString * URLVideo;
@property (nonatomic, retain) NSString * Producteur;
@property (nonatomic, retain) NSString * Description;
@property (nonatomic, retain) PFObject *Video;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@end
