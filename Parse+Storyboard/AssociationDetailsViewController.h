//
//  AssociationDetailsViewController.h
//  AdUnLock
//
//  Created by Emilien Sanchez on 30/03/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AssociationDetailsViewController : UIViewController

//Asso Info from Get Asso
@property (nonatomic) PFObject *AssoPass;

//Asso Detail
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *Titre;
@property (weak, nonatomic) IBOutlet UILabel *Theme;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UIButton *Valider;
@property (weak, nonatomic) IBOutlet UILabel *separator;

- (IBAction)ChgtAsso:(id)sender;




@end
