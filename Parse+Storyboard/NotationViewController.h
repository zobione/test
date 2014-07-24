//
//  NotationViewController.h
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 05/03/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "RateView.h"

@interface NotationViewController : UIViewController
<UIPickerViewDataSource, UIPickerViewDelegate, RateViewDelegate>

- (IBAction)exitkeyboard:(id)sender;

- (IBAction)TouchOutside:(id)sender;

@property (nonatomic) NSMutableArray *assoNom;
@property (nonatomic) NSArray *pickValue2;
@property (nonatomic) NSString *assoNomQuery;
@property (nonatomic) UIPickerView *myPickerView;

@property (nonatomic) PFObject *VideoPass;
@property (nonatomic) PFObject *AssoPass;
@property (weak, nonatomic) IBOutlet RateView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic) float *rating2;
@property (weak, nonatomic) IBOutlet UITextField *FavAsso;

@end
