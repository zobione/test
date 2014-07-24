//
//  MyProfileViewController.h
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 03/03/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface MyProfileViewController : UITableViewController
- (IBAction)Deconnexion:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *Username;
@property (weak, nonatomic) IBOutlet UILabel *birthDate;
@property (weak, nonatomic) IBOutlet UILabel *email;


@property (weak, nonatomic) IBOutlet UIImageView *LogoAsso;
@property (weak, nonatomic) IBOutlet UILabel *AssoNom;
@property (weak, nonatomic) IBOutlet UILabel *AssoTheme;
@property (weak, nonatomic) IBOutlet UILabel *AssoDesc;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@end
