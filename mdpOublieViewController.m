//
//  mdpOublieViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 06/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "mdpOublieViewController.h"
#import <Parse/Parse.h>
#import "SignLogViewController.h"
#import "MBProgressHUD.h"

@interface mdpOublieViewController ()

@end

@implementation mdpOublieViewController
@synthesize Gimmi, retour, explication, email,envoyer,loginView,originalTextViewFrame;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Fond.png"]]];
    Gimmi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo2.png"]];
    [Gimmi setFrame:CGRectMake(self.view.frame.size.width/2 - 50, email.frame.origin.y - self.view.frame.size.height/10, 100, 37.5)];
    [self.view addSubview:Gimmi];
    UIFont *yourFont3 = [UIFont fontWithName:@"Roboto-Light" size:14];
    [email setFont:yourFont3];
    [explication setFont:yourFont3];
    

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
    
    CGPoint centreUsername = CGPointMake(self.loginView.frame.size.width/2, newTextViewFrame.size.height/2 - 80);
    
    
    CGPoint centreQuestion = CGPointMake(self.loginView.frame.size.width/2, newTextViewFrame.size.height/2);
    
    CGPoint centreConnexion = CGPointMake(self.loginView.frame.size.width/2 +116/2 + 10.5, newTextViewFrame.size.height/2 + 100);
    
    CGPoint centreRetour = CGPointMake(self.loginView.frame.size.width/2 -116/2 - 10.5, newTextViewFrame.size.height/2 + 100);
    

    [self.email setCenter:centreUsername];
    [self.explication setCenter:centreQuestion];
    [self.retour setCenter:centreRetour];
    [self.envoyer setCenter:centreConnexion];
    [self.loginView setFrame:newTextViewFrame];
    [Gimmi setFrame:CGRectMake(self.view.frame.size.width/2 - 40, email.frame.origin.y - self.view.frame.size.height/2, 80, 30)];
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

- (IBAction)envoyer:(id)sender {
    NSString *email1 = self.email.text;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Verification de l'email";
    [hud show:YES];

    
    
    [PFUser requestPasswordResetForEmailInBackground:email1 block:^(BOOL succeeded, NSError *error) {
        [hud hide:YES];
        if(!error){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
            SignLogViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"SignLog"];
            [self presentViewController:lvc animated:YES completion:nil];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"OK" message:@"Email envoyé" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];

        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];

        }
    }];
}
@end
