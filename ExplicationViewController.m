//
//  ExplicationViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 04/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "ExplicationViewController.h"

@interface ExplicationViewController ()

@end

@implementation ExplicationViewController
@synthesize AssoPass;
@synthesize ExplicationAsso;
@synthesize LogoAsso;
@synthesize bouttonRetour;

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
    ExplicationAsso.text = AssoPass[@"Description_Courte"];
    PFFile *imageFile = [AssoPass objectForKey:@"LogoListeAssos"];
    NSData *imageData = [imageFile getData];
    UIImage *image2 = [UIImage imageWithData:imageData];
    [LogoAsso setImage:image2];
    
    CGPoint iphone4 = CGPointMake(0, 20);
    CGPoint iphone5 = CGPointMake(0, 50);
    
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
    [LogoAsso setFrame:CGRectMake(self.view.frame.size.width/2 - 75, self.view.frame.size.height/4 - 75, 150, 150)];
    
    [ExplicationAsso setFrame:CGRectMake(self.view.frame.size.width/2 - ExplicationAsso.frame.size.width/2, LogoAsso.frame.origin.y + LogoAsso.frame.size.height + offset.y, ExplicationAsso.frame.size.width, ExplicationAsso.frame.size.height)];
    UIFont *yourFont = [UIFont fontWithName:@"Roboto-Light" size:13];
    [ExplicationAsso setFont:yourFont];
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
