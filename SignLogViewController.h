//
//  SignLogViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 24/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignLogViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *inscripiotn;
@property (weak, nonatomic) IBOutlet UIButton *Annonyme;
- (IBAction)AnonymeConnexion:(id)sender;

@end
