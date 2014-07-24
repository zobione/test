//
//  ChoixViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 24/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "ChoixViewController.h"
#import "HomeViewController.h"
#import "SignLogViewController.h"

@interface ChoixViewController ()

@end

@implementation ChoixViewController

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
    
   }

-(void)viewDidAppear:(BOOL)animated
{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        NSLog(@"Logged");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        HomeViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Root"];
        [self presentViewController:lvc animated:NO completion:nil];
    }  else {
        NSLog(@"Login or sign up required");
            //do
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        SignLogViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"SignLog"];
        [self presentViewController:lvc animated:NO completion:nil];
    }

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

@end
