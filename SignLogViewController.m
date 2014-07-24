//
//  SignLogViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 24/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "SignLogViewController.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"
#import "MBProgressHUD.h"

@interface SignLogViewController ()

@end

@implementation SignLogViewController
@synthesize login;
@synthesize inscripiotn;
@synthesize Annonyme;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Fond.png"]]];
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]];
    [logo setFrame:CGRectMake(self.view.frame.size.width/2 - self.view.frame.size.width/4, self.view.frame.size.height/2 - self.view.frame.size.height/4, self.view.frame.size.width/2, self.view.frame.size.width/2)];
    [self.view addSubview:logo];
    [inscripiotn setFrame:CGRectMake(inscripiotn.frame.origin.x, self.view.frame.size.height - 70, inscripiotn.frame.size.width, inscripiotn.frame.size.height)];
    [login setFrame:CGRectMake(login.frame.origin.x, self.view.frame.size.height - 120, login.frame.size.width, login.frame.size.height)];
    [Annonyme setFrame:CGRectMake(Annonyme.frame.origin.x, self.view.frame.size.height - 170, Annonyme.frame.size.width, Annonyme.frame.size.height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)AnonymeConnexion:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Création du compte...";
    [hud show:YES];
    
    [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
        [hud hide:YES];
        if (error) {
            NSLog(@"Anonymous login failed.");
        } else {
            NSLog(@"Anonymous user logged in.");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
            HomeViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Tuto"];
            [self presentViewController:lvc animated:YES completion:nil];

        }
    }];
}
@end
