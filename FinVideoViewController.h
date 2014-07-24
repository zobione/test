//
//  FinVideoViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 04/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FinVideoViewController : UIViewController
{
    CGPoint offset;
}

@property (nonatomic) PFObject *AssoPass;
@property (weak, nonatomic) IBOutlet UIImageView *LogoAsso;
@property (weak, nonatomic) IBOutlet UILabel *ligne1;
@property (weak, nonatomic) IBOutlet UILabel *explication;
@property (weak, nonatomic) IBOutlet UIButton *bouttonRetour;

@property (weak, nonatomic) IBOutlet UILabel *NomAsso;
@property (weak, nonatomic) IBOutlet UIImageView *Blur;

@end
