//
//  DefaultSettingsViewController.m
//  Parse+Storyboard
//
//  Created by Juan Figuera on 9/23/12.
//  Copyright (c) 2012 Juan Figuera. All rights reserved.
//

#import "DefaultSettingsViewController.h"


@implementation DefaultSettingsViewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background2.jpg"]]];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    if ([PFUser currentUser]) {
        //[welcomeLabel setText:[NSString stringWithFormat:@"Welcome Back %@!", [[PFUser currentUser] username]]];
        NSLog(@"PFUser is not current user");
        
    } else {
        NSLog(@"PFUser is current user");
        //[welcomeLabel setText:@"Not logged in"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        
        
    } else {
        
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
