//
//  MyProfileViewController.m
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 03/03/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import "MyProfileViewController.h"
#import "SWRevealViewController.h"
#import "MBProgressHUD.h"


@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

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
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        
    
    _Username.text = [[PFUser currentUser]username];
    _email.text = [[PFUser currentUser]email];
    
    PFQuery *query2= [PFUser query];
    query2.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query2 whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    [query2 includeKey:@"Association"];
    [query2 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        
        if (!error) {
            
       
        _birthDate.text = [object objectForKey:@"additional"];

        PFObject *asso = [object objectForKey:@"Association"];
        //NSString *Nom = asso[@"Nom"];
        //_Association.text = Nom;
        _AssoNom.text = asso[@"Nom"];
        _AssoTheme.text = asso[@"Theme"];
        _AssoDesc.text = asso[@"Description_Courte"];
        
        PFFile *imageFile = [asso objectForKey:@"LogoProfil"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:result];
                _LogoAsso.image = image;
            }
        }];

        
        NSLog(@"Successfully retrieved date:%@ and image",_birthDate.text);
         }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
        
        
    });
    
    [super viewDidLoad];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (IBAction)Deconnexion:(id)sender {
    
    [PFUser logOut];
    
    /*
    [self.navigationController popViewControllerAnimated:YES];
    
    MyLoginViewController *logInViewController = [[MyLoginViewController alloc] init];
    logInViewController.fields = PFLogInFieldsUsernameAndPassword
    | PFLogInFieldsLogInButton
    | PFLogInFieldsSignUpButton
    | PFLogInFieldsPasswordForgotten;
    [logInViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Create the sign up view controller
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    [signUpViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Deconnexion"]){
        [PFUser logOut];
        
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
