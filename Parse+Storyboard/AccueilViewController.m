//
//  AccueilViewController.m
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 26/02/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import "AccueilViewController.h"
#import "NotationViewController.h"
#import "MBProgressHUD.h"
#import "SWRevealViewController.h"

@interface AccueilViewController ()

@end


@implementation AccueilViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization


    }
    return self;
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background2.jpg"]]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75.0/255.0 green:193.0/255.0 blue:210.0/255.0 alpha:1]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo2.png"]];
    /*
    _Association.font = [UIFont fontWithName:@"Roboto-Medium" size:14];
    _videoName.font = [UIFont fontWithName:@"Roboto-Medium" size:14];
    _Message.font = [UIFont fontWithName:@"Roboto-Thin" size:13];
    _DateComment.font = [UIFont fontWithName:@"Roboto-Regular" size:10];
    [_Soutient setFont:[UIFont fontWithName:@"Roboto-Thin" size:128.0]];
    [_Titre setFont:[UIFont fontWithName:@"Roboto-Thin" size:128.0]];
     */
    
    [super viewDidLoad];
    
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
    //Visualisation choix de l'asso
    PFQuery *getAsso= [PFUser query];
    [getAsso whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    [getAsso includeKey:@"Association"];
    [getAsso getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        PFObject *asso = [object objectForKey:@"Association"];
        //NSString *Nom = asso[@"Nom"];
        _Association.text = asso[@"Nom"];
        _Asso = asso;
        
        
    }];
        

    
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
            NSLog(@"Number of video: %lu", (unsigned long)[cars count]);
            
            PFObject *randomCar = [cars objectAtIndex:arc4random() % [cars count]];
            _videoName.text = randomCar[@"Titre"];
            _URLVideo = randomCar[@"url"];
            _Producteur = randomCar[@"Producteur"];
            _Description = randomCar[@"Description"];
            _Video = randomCar;
            
            NSLog(@"Successfully retrieved titre %@ and URL %@ and Producteur %@ and description %@.", _videoName.text, _URLVideo, _Producteur, _Description);
        });
        
    });
    
    //Message des developpeurs
    
    PFQuery *GetMessage = [PFQuery queryWithClassName:@"Comment"];
    GetMessage.cachePolicy = kPFCachePolicyCacheElseNetwork;
    GetMessage.limit = 1;
    [GetMessage whereKeyExists:@"objectId"];
    [GetMessage addDescendingOrder:@"createdAt"];
    [GetMessage getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        _DateComment.text = [object objectForKey:@"Date"];
        _Message.text = [object objectForKey:@"texte"];
        NSLog(@"Successfully retrieved Message + Date.");
    }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    

       
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

 */



- (IBAction)playMovie:(id)sender {
    NSURL *url = [NSURL URLWithString:_URLVideo];

    _moviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];

}

- (void) moviePlayBackDidFinish:(NSNotification*)notification{
    
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
            [self presentViewController:lvc animated:YES completion:nil];
            //[self.navigationController pushViewController:lvc animated:YES];
            
            //NotationViewController *viewController = [[NotationViewController alloc] init];
            //[self presentViewController:viewController animated:YES completion:nil];
            
            
            NSLog(@"Switch View");
            
            break;
            /*
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"playback error");
            break;
        case MPMovieFinishReasonUserExited:
            NSLog(@"user has exited");
            break;
        default:
            NSLog(@"unknown finish reason");*/
    }

    
}

@end
