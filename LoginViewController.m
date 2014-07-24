//
//  LoginViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 26/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"
#import "MBProgressHUD.h"

@interface LoginViewController ()


@end

@implementation LoginViewController
@synthesize loginView;
@synthesize originalTextViewFrame;
@synthesize username;
@synthesize password;
@synthesize question;
@synthesize connexion;
@synthesize Gimmi;
@synthesize retour;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //[loginView setText:_notesText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Fond.png"]]];
    Gimmi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo2.png"]];
    [Gimmi setFrame:CGRectMake(self.view.frame.size.width/2 - 50, username.frame.origin.y - self.view.frame.size.height/10, 100, 37.5)];
    [self.view addSubview:Gimmi];
    
    UIFont *yourFont3 = [UIFont fontWithName:@"Roboto-Light" size:14];
    [username setFont:yourFont3];
    [password setFont:yourFont3];
    [question setFont:yourFont3];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification*)notification {
    [self moveTextViewForKeyboard:notification up:YES];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    [self moveTextViewForKeyboard:notification up:NO];
}

- (void)moveTextViewForKeyboard:(NSNotification*)notification up:(BOOL)up {
    NSLog(@"move view");
    
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardRect;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.loginView.frame;
    originalTextViewFrame = self.loginView.frame;
    newTextViewFrame.size.height = keyboardTop - loginView.frame.origin.y - 10;
    
    CGPoint centreUsername = CGPointMake(self.loginView.frame.size.width/2, newTextViewFrame.size.height/2 - 25);

    CGPoint centrePassword = CGPointMake(self.loginView.frame.size.width/2, newTextViewFrame.size.height/2 + 25);

    CGPoint centreQuestion = CGPointMake(self.loginView.frame.size.width/2, newTextViewFrame.size.height/2 + 60);
    
    CGPoint centreConnexion = CGPointMake(self.loginView.frame.size.width/2 +116/2 + 10.5, newTextViewFrame.size.height/2 + 100);
    
    CGPoint centreRetour = CGPointMake(self.loginView.frame.size.width/2 -116/2 - 10.5, newTextViewFrame.size.height/2 + 100);

    
    [self.question setCenter:centreQuestion];
    [self.connexion setCenter:centreConnexion];
    [self.loginView setFrame:newTextViewFrame];
    [self.username setCenter:centreUsername];
    [self.password setCenter:centrePassword];
    [self.retour setCenter:centreRetour];
    [Gimmi setFrame:CGRectMake(self.view.frame.size.width/2 - 40, username.frame.origin.y - self.view.frame.size.height/10, 80, 30)];
    [UIView commitAnimations];
    
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

- (IBAction)connexion:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Authentification";
    [hud show:YES];
    
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text block:^(PFUser *user, NSError *error) {
        [hud hide:YES];
        if (error!=nil) {
            //something bad has occured
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        } else {
            //open the wall
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
            HomeViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Root"];
            NSLog(@"username %@", [[PFUser currentUser] username]);
            [self presentViewController:lvc animated:YES completion:nil];
        }
    }];
}
@end
