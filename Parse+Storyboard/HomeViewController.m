//
//  HomeViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 15/04/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "HomeViewController.h"
#import "NotationViewController.h"
#import "MBProgressHUD.h"
#import "SWRevealViewController.h"
#import <AdColony/AdColony.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize Ligne1;
@synthesize Ligne2;
@synthesize Ligne3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background2.png"]]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75.0/255.0 green:193.0/255.0 blue:210.0/255.0 alpha:1]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo2.png"]];
	// Do any additional setup after loading the view.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    

    
    
    
    [super viewDidLoad];
    
    
    PFUser *user = [PFUser currentUser];
    NSString *username = user.username;
    //PFObject *Association = user[@"Association"];
    //NSString *Asso = Association[@"Nom"];
    NSLog(@"username: %@", username);
    
    [self.BouttonPrincipal setFrame:CGRectMake(self.BouttonPrincipal.frame.origin.x, self.view.frame.size.height/2 - self.BouttonPrincipal.frame.size.height/3, self.BouttonPrincipal.frame.size.width, self.BouttonPrincipal.frame.size.height)];
    [Ligne1 setFrame:CGRectMake(Ligne1.frame.origin.x, self.view.frame.size.height/2 - Ligne1.frame.size.height/3 + 260/2, Ligne1.frame.size.width, Ligne1.frame.size.height)];
    [Ligne2 setFrame:CGRectMake(Ligne2.frame.origin.x, self.view.frame.size.height/2 - Ligne2.frame.size.height/3 + 300/2, Ligne2.frame.size.width, Ligne2.frame.size.height)];
    
    /*
    Ligne1.font = [UIFont fontWithName:@"LeckerliOne" size:17];
    Ligne2.font = [UIFont fontWithName:@"LeckerliOne" size:17];
    Ligne3.font = [UIFont fontWithName:@"LeckerliOne" size:17];
    Ligne1.textColor=[UIColor colorWithRed:(110.0 / 255.0) green:(110.0 / 255.0) blue:(110.0 / 255.0) alpha: 1];
    Ligne2.textColor=[UIColor colorWithRed:(110.0 / 255.0) green:(110.0 / 255.0) blue:(110.0 / 255.0) alpha: 1];
    Ligne3.textColor=[UIColor colorWithRed:(110.0 / 255.0) green:(110.0 / 255.0) blue:(110.0 / 255.0) alpha: 1];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        //Visualisation choix de l'asso
        PFQuery *getAsso= [PFUser query];
        [getAsso whereKey:@"username" equalTo:[[PFUser currentUser]username]];
        [getAsso includeKey:@"Association"];
        [getAsso getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
            PFObject *asso = [object objectForKey:@"Association"];
            //NSString *Nom = asso[@"Nom"];
            _Asso = asso;
            
            if (!error) {
                //Choix random video
                
                
                
                // Construct the query
                PFQuery *longQuery = [PFQuery queryWithClassName:@"Video"];
                [longQuery whereKey:@"ID" greaterThan:@0];
                [longQuery orderByAscending:@"ID"];
                
                // Create the output variables
                __block NSMutableArray *cars = [NSMutableArray array];
                __block int currentIndex = 0;
     
                // Run the querying process in the background
                dispatch_queue_t bgQ = dispatch_queue_create("bgQ", 0);
                dispatch_async(bgQ, ^{
                    
                    // Calculate the number of objects conforming to the query
                    int objectsInQuery = [longQuery countObjects];
                    int numberOfQueries = objectsInQuery / 100;
                    if (objectsInQuery % 100 != 0) {
                        numberOfQueries += 1;
                    }
                    
                    // Loop through the querys
                    for (int i = 0; i < numberOfQueries; i++) {
                        
                        // Increment the position in the querry
                        [longQuery whereKey:@"ID" greaterThan:[NSNumber numberWithInt:currentIndex]];
                        
                        // Loop through the objects
                        NSArray *objs = [longQuery findObjects];
                        for (PFObject *car in objs) {
                            [cars addObject:car];
                        }
                        
                        // Increment the current position
                        currentIndex += [objs count];
                    }
                    
                    // Use the response in the UI thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"Number of video: %i", [cars count]);
                        
                        PFObject *randomCar = [cars objectAtIndex:arc4random() % [cars count]];
                        
                        _URLVideo = randomCar[@"url"];
                        _Producteur = randomCar[@"Producteur"];
                        _Description = randomCar[@"Description"];
                        _Video = randomCar;
                        
                        NSLog(@"Successfully retrieved titre %@ and URL %@ and Producteur %@ and description %@.", randomCar[@"Titre"], _URLVideo, _Producteur, _Description);
                    });
                    
                });
                
                PFQuery *query = [PFQuery queryWithClassName:@"Association"];
                [query whereKeyExists:@"Nom"];
                //_assoNom = [query findObjects];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        // The find succeeded.
                        NSLog(@"Successfully retrieved %d assos.", objects.count);
                        // Do something with the found objects
                        
                        _pickValue = [NSArray array];
                        
                        for (PFObject *object in objects) {
                            
                            _assoNomQuery = object[@"Nom"];
                            NSLog(@"%@", _assoNomQuery);
                            _pickValue = [_pickValue arrayByAddingObject:_assoNomQuery];
                            NSLog(@"%@", _pickValue);
                            //assoNom = [[NSMutableArray alloc] init];
                            //[assoNom addObject:assoNomQuery];
                            
                            
                            
                        }
                    }
                }];
                 
                 

                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });

            }
            
        }];
        
        
        
            });
     */
    
    levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
                
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Play:(id)sender {
    /*
    
    NSLog(@"loading %@", _URLVideo);
    NSURL *url = [NSURL URLWithString:_URLVideo];
    
    _moviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:url];
    
    NSLog(@"Successfully launch video player");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];
     
     */
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification{
    /*
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
        
    }
    
    
    NSNumber *resultValue = [notification.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    MPMovieFinishReason reason = [resultValue intValue];
    switch(reason)
    {
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"playback entirely done and finished");
            //[self performSegueWithIdentifier:@"nam" sender:self];
            //A changer pour switcher la vue
            
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
            NotationViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Notation"];
            lvc.VideoPass = _Video;
            lvc.AssoPass = _Asso;
            lvc.pickValue2 = _pickValue;
            [self presentViewController:lvc animated:YES completion:nil];
            //[self.navigationController pushViewController:lvc animated:YES];
            
            //NotationViewController *viewController = [[NotationViewController alloc] init];
            //[self presentViewController:viewController animated:YES completion:nil];
            
            
            NSLog(@"Switch View");
            
            break;
     
             case MPMovieFinishReasonPlaybackError:
             NSLog(@"playback error");
             break;
             case MPMovieFinishReasonUserExited:
             NSLog(@"user has exited");
             break;
             default:
             NSLog(@"unknown finish reason");
     }
    */
    
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)levelTimerCallback:(NSTimer *)timer {
	//NSLog(@"Average input");
    if ([AdColony zoneStatusForZone:@"vza993a2ac11ba445c9e"] == ADCOLONY_ZONE_STATUS_ACTIVE) {
       //NSLog(@"OK");
        self.BouttonPub.enabled = TRUE;
        self.BouttonPrincipal.enabled = true;
        Ligne1.text =@"";
        Ligne2.text = @"";
        
    } else {
        self.BouttonPub.enabled = false;
        self.BouttonPrincipal.enabled = false;
        Ligne1.text =@"Aucune publicité n'est disponible pour le moment";
        Ligne2.text= @"Merci de patienter les publicitées vont revenir!";
    }
}

#pragma mark -
#pragma mark AdColony-specific
-(IBAction)triggerVideo
{
    ADCOLONY_ZONE_STATUS t = [AdColony zoneStatusForZone:@"vza993a2ac11ba445c9e"];
    if (t == ADCOLONY_ZONE_STATUS_ACTIVE) {
        //do
        [AdColony playVideoAdForZone:@"vza993a2ac11ba445c9e" withDelegate:self];
    } else {
        NSLog(@"Pas de video");
    }
    
}

-(void)onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneID
{
    NSLog(@"Ad finished");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de chargement..." message:@"Merci de votre don!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        NSLog(@"annonyme");
        //done
        PFUser *user = [PFUser currentUser];
        NSLog(@"%@",user.username);
        PFQuery *query= [PFUser query];
        [query whereKey:@"username" equalTo: [[PFUser currentUser]username]];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        PFObject *Association = object[@"Association"];
            PFObject *gameScore = [PFObject objectWithClassName:@"Visionnage"];
            gameScore[@"Association"] = Association;
            gameScore[@"User"] = user;
            gameScore[@"Note"] = @"Adcolony";
            //gameScore[@"Video"] = @"Adcolony";
            [gameScore saveInBackground];
        }];

        
    } else {
        PFUser *user = [PFUser currentUser];
        PFObject *Association = user[@"Association"];
        
        
        PFObject *gameScore = [PFObject objectWithClassName:@"Visionnage"];
        gameScore[@"Association"] = Association;
        gameScore[@"User"] = user;
        gameScore[@"Note"] = @"Adcolony";
        //gameScore[@"Video"] = @"Adcolony";
        [gameScore saveInBackground];
    }
    

    
}

@end
