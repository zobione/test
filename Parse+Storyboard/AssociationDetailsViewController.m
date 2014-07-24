//
//  AssociationDetailsViewController.m
//  AdUnLock
//
//  Created by Emilien Sanchez on 30/03/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import "AssociationDetailsViewController.h"
#import "GetAssoViewController.h"
#import "AccueilViewController.h"
#import "MBProgressHUD.h"


@interface AssociationDetailsViewController ()

@end

@implementation AssociationDetailsViewController
@synthesize Image;
@synthesize Theme;
@synthesize Titre;
@synthesize description;
@synthesize Valider;
@synthesize separator;


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

    Titre.text = _AssoPass[@"Nom"];
    Theme.text = _AssoPass[@"Theme"];
    description.text = _AssoPass[@"Description_Courte"];
    


    PFFile *imageFile = _AssoPass[@"LogoPageAsso"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
        if (!error) {
            UIImage *img = [UIImage imageWithData:result];
            Image.image = img;
        }
    }];
      [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background2.jpg"]]];
    [super viewDidLoad];
    
    UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:1];
    navCon.navigationItem.title = _AssoPass[@"Nom"];

	// Do any additional setup after loading the view.
    
    int screenHeight = self.view.bounds.size.height;
    if (screenHeight<500) {
        //Show the UIImage for iPhone 4.
        [self.Valider setFrame:CGRectMake(self.Valider.frame.origin.x, self.view.frame.size.height - 50, self.Valider.frame.size.width, self.Valider.frame.size.height)];
        [description setFrame:CGRectMake(description.frame.origin.x, self.view.frame.size.height - 210, description.frame.size.width, description.frame.size.height)];
         [separator setFrame:CGRectMake(separator.frame.origin.x, self.view.frame.size.height - 245, separator.frame.size.width, separator.frame.size.height)];
         [Titre setFrame:CGRectMake(Titre.frame.origin.x, self.view.frame.size.height - 230, Titre.frame.size.width, Titre.frame.size.height)];
         [Theme setFrame:CGRectMake(Theme.frame.origin.x, self.view.frame.size.height - 215, Theme.frame.size.width, Theme.frame.size.height)];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SelectAsso"]){
        
        
    }
    
}
*/


- (IBAction)ChgtAsso:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Mise à jour";
    [hud show:YES];
    
    PFQuery *query= [PFUser query];
    [query whereKey:@"username" equalTo: [[PFUser currentUser]username]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
    object[@"Association"] = _AssoPass;
        

        
        // Upload recipe to Parse
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [hud hide:YES];
            
            if (!error) {
                // Show success message
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Changement effectués!" message:@"Votre association à bien été mise à jour" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
                AccueilViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Root"];
                [self presentViewController:lvc animated:YES completion:nil];
            
                
                //[self performSegueWithIdentifier:@"UpdateAsso" sender:sender];
                
                // Dismiss the controller
                //[self dismissViewControllerAnimated:YES completion:nil];
                
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de chargement..." message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }];
    }];

    
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
