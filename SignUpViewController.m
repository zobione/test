//
//  SignUpViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 27/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"
#import "MBProgressHUD.h"

@interface SignUpViewController ()
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation SignUpViewController
@synthesize username;
@synthesize email;
@synthesize password;
@synthesize password2;
@synthesize question;
@synthesize inscription;
@synthesize Gimmi;
@synthesize originalTextViewFrame;
@synthesize loginView;
@synthesize datePicker;
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
    
    datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    [self.password2 setInputView:datePicker];
    UIFont *yourFont3 = [UIFont fontWithName:@"Roboto-Light" size:14];
    [username setFont:yourFont3];
    [password setFont:yourFont3];
    [password2 setFont:yourFont3];
    [question setFont:yourFont3];
    [email setFont:yourFont3];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.password2.inputView;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    
    NSDate *date = picker.date; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    NSLog(@"Converted String : %@",convertedString);
    
    
    self.password2.text = [NSString stringWithFormat:@"%@",convertedString];
    password2.text = [NSString stringWithFormat:@"%@",convertedString];
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
    
    CGPoint centreEmail = CGPointMake(self.loginView.frame.size.width/2, newTextViewFrame.size.height/2 - 40);
    
    CGPoint centrePassword = CGPointMake(self.loginView.frame.size.width/2, newTextViewFrame.size.height/2 + 40);
    
     CGPoint centrePassword2 = CGPointMake(self.loginView.frame.size.width/2, newTextViewFrame.size.height/2 + 0);
    
    CGPoint centreQuestion = CGPointMake(self.loginView.frame.size.width/2, newTextViewFrame.size.height/2 + 65);
    
    CGPoint centreConnexion = CGPointMake(self.loginView.frame.size.width/2 +116/2 + 10.5, newTextViewFrame.size.height/2 + 100);
    
    CGPoint centreRetour = CGPointMake(self.loginView.frame.size.width/2 -116/2 - 10.5, newTextViewFrame.size.height/2 + 100);
    
    [self.username setCenter:centreUsername];
    [self.email setCenter:centreEmail];
    [self.password setCenter:centrePassword];
    [self.password2 setCenter:centrePassword2];
    [self.question setCenter:centreQuestion];
    [self.inscription setCenter:centreConnexion];
    [self.loginView setFrame:newTextViewFrame];
    [self.retour setCenter:centreRetour];
    [Gimmi setFrame:CGRectMake(self.view.frame.size.width/2 - 40, username.frame.origin.y - self.view.frame.size.height/2, 80, 30)];
    [UIView commitAnimations];
    
}


- (IBAction)signUp:(id)sender {
    
    NSString *myString = email.text;
    BOOL mail = NO;
    if ([myString rangeOfString:@"@"].location == NSNotFound) {
        NSLog(@"Not found!");
        mail = NO;
    } else {
        NSLog(@"Display and Alert!");
        mail = YES;
    }
    
    //if (username.text != nil && email.text!=nil && password.text!=nil && password2.text!=nil && password.text == password2.text && password.text.length > 5 && mail == YES) {
        PFUser *user = [PFUser user];
        //2
        NSLog(@"Log in");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Création du compte...";
    [hud show:YES];
    
        user.username = self.username.text;
        user.password = self.password.text;
        user.email = self.email.text;
        user[@"Date_de_Naissance"] = self.password2.text;
        //3
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [hud hide:YES];
            if (!error) {
                
                //The registration was successful, go to the wall
                //[self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
                HomeViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Tuto"];
                [self presentViewController:lvc animated:YES completion:nil];
                
            } else {
                //Something bad has occurred
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Erreur" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorAlertView show];
            }
        }];
    
    /*
    } else if (username.text == nil || email.text==nil) {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"merci de completer tous les champs" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
    } else if (password.text.length < 6) {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Votre mot de passe doit contenir au minimum 6 caractères" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
    } else if (mail == NO) {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Merci de renseigner un email valide!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }
    */
    
}
@end
