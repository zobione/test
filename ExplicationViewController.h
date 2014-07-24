//
//  ExplicationViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 04/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ExplicationViewController : UIViewController
{
    CGPoint offset;
}


@property (weak, nonatomic) IBOutlet UIImageView *LogoAsso;
@property (weak, nonatomic) IBOutlet UILabel *ExplicationAsso;
@property (nonatomic) PFObject *AssoPass;
@property (weak, nonatomic) IBOutlet UIButton *bouttonRetour;

@end
