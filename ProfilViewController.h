//
//  ProfilViewController.h
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 23/02/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfilViewController : UIViewController
- (IBAction)signOut:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *NomAsso;
@property (weak, nonatomic) IBOutlet UILabel *Username;


@end
