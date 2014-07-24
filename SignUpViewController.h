//
//  SignUpViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 27/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UIButton *question;
@property (weak, nonatomic) IBOutlet UIButton *inscription;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *retour;

@property (strong, nonatomic) UIImageView *Gimmi;

@property (nonatomic) CGRect originalTextViewFrame;
- (IBAction)signUp:(id)sender;

@end
