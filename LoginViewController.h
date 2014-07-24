//
//  LoginViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 26/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIView *loginView;
- (IBAction)connexion:(id)sender;
@property (nonatomic) CGRect originalTextViewFrame;

@property (weak, nonatomic) IBOutlet UIButton *question;
@property (weak, nonatomic) IBOutlet UIButton *connexion;
@property (strong, nonatomic) UIImageView *Gimmi;
@property (weak, nonatomic) IBOutlet UIButton *retour;


@end
