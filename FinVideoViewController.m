//
//  FinVideoViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 04/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "FinVideoViewController.h"

@interface FinVideoViewController ()

@end

@implementation FinVideoViewController
@synthesize AssoPass;
@synthesize LogoAsso;
@synthesize NomAsso;
@synthesize ligne1;
@synthesize explication;
@synthesize bouttonRetour;
@synthesize Blur;

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
    [self.view setBackgroundColor:[UIColor blackColor]];
    PFFile *imageFile = [AssoPass objectForKey:@"LogoListeAssos"];
    NSData *imageData = [imageFile getData];
    UIImage *image2 = [UIImage imageWithData:imageData];
    [LogoAsso setImage:image2];
    NomAsso.text = AssoPass[@"Nom"];
    
    
    CGPoint iphone4 = CGPointMake(30, 20);
    CGPoint iphone5 = CGPointMake(0, 0);
    
    int screenHeight = self.view.bounds.size.height;
    if (screenHeight<500) {
        //Show the UIImage for iPhone 4.
        offset = iphone4;
    }
    else {
        //Show the UIImage for iPhone 5.
        offset = iphone5;
    }
    
    [bouttonRetour setFrame:CGRectMake(self.view.frame.size.width/2 - bouttonRetour.frame.size.width/2, self.view.frame.size.height - 80,bouttonRetour.frame.size.width,bouttonRetour.frame.size.height)];
    
    UIFont *yourFont = [UIFont fontWithName:@"Roboto-Bold" size:17];
    UIFont *yourFont2 = [UIFont fontWithName:@"Roboto-Black" size:22];
    UIFont *yourFont3 = [UIFont fontWithName:@"Roboto-Light" size:14];
    
    [LogoAsso setFrame:CGRectMake(self.view.frame.size.width/2 - 75, self.view.frame.size.height/2 - 75 - offset.x, 150, 150)];
    
    [NomAsso setFrame:CGRectMake(self.view.frame.size.width/2 - NomAsso.frame.size.width/2, LogoAsso.frame.origin.y - 70 , NomAsso.frame.size.width, NomAsso.frame.size.height)];
    [NomAsso setFont:yourFont2];
    [ligne1 setFrame:CGRectMake(self.view.frame.size.width/2 - ligne1.frame.size.width/2, LogoAsso.frame.origin.y - 100 , ligne1.frame.size.width, ligne1.frame.size.height)];
    [ligne1 setFont:yourFont];
    [explication setFrame:CGRectMake(self.view.frame.size.width/2 - explication.frame.size.width/2, LogoAsso.frame.origin.y + LogoAsso.frame.size.height + 30 - offset.y/2, explication.frame.size.width, explication.frame.size.height)];
    [explication setFont:yourFont3];
    [self.view bringSubviewToFront:LogoAsso];
    
    [Blur setFrame:CGRectMake(self.view.frame.size.width/2 - 125, self.view.frame.size.height/2 - 125 - offset.x, 250, 250)];
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
