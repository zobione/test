//
//  HomeCollecViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 01/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "HomeCollecViewController.h"
#import "MBProgressHUD.h"
#import "SWRevealViewController.h"

@interface HomeCollecViewController ()

@end

@implementation HomeCollecViewController
@synthesize bouttonReveal;

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
    
    bouttonReveal.target = self.revealViewController;
    bouttonReveal.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        NSLog(@"Started");
   

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75.0/255.0 green:193.0/255.0 blue:210.0/255.0 alpha:1]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo2.png"]];


    [self.containerView setFrame:CGRectMake(self.containerView.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:@"refreshView" object:nil];
  


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

- (BOOL)shouldAutorotate
{
    return NO;
}

-(void)refreshView:(NSNotification *) notification {
    
    //CODE TO REFRESH THE VIEW HERE
    NSLog(@"refresh");
    [self viewDidLoad];
    
}


@end
