//
//  mdpOublieViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 06/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mdpOublieViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UILabel *explication;
@property (weak, nonatomic) IBOutlet UIButton *retour;
@property (weak, nonatomic) IBOutlet UIButton *envoyer;
@property (strong, nonatomic) UIImageView *Gimmi;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (nonatomic) CGRect originalTextViewFrame;
- (IBAction)envoyer:(id)sender;

@end
