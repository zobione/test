//
//  NotationViewController.m
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 05/03/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import "NotationViewController.h"
#import "AccueilViewController.h"
#import "MBProgressHUD.h"

@interface NotationViewController ()



@end

@implementation NotationViewController
@synthesize rateView;
@synthesize statusLabel;
@synthesize assoNom;
@synthesize assoNomQuery;
@synthesize myPickerView;

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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background2.jpg"]]];
    
    [super viewDidLoad];
    self.rateView.notSelectedImage = [UIImage imageNamed:@"Starempty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"starplain.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"starplain.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    
    
    _FavAsso.text = _AssoPass[@"Nom"];
    
	// Do any additional setup after loading the view.
    //PickerView
    
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    myPickerView.dataSource = self;
    _FavAsso.inputView = myPickerView;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    self.statusLabel.text = [NSString stringWithFormat:@"%f", rating];
    self.rating2 = &(rating);
}

- (void)didReceiveMemoryWarning
{
    [self setRateView:nil];
    [self setStatusLabel:nil];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SendData"]){
        
        PFQuery *query = [PFQuery queryWithClassName:@"Association"];
        [query whereKey:@"Nom" equalTo:_FavAsso.text];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                
                PFObject *gameScore = [PFObject objectWithClassName:@"Visionnage"];
                gameScore[@"User"] = [PFUser currentUser];
                gameScore[@"Video"] = _VideoPass;
                gameScore[@"Association"] = object;
                gameScore[@"Note"] = statusLabel.text;
                [gameScore saveInBackground];
                
                NSLog(@"Done");

            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];

        

        
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Merci, votre association à reçu 0,02€!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
        
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    _FavAsso.text = [_pickValue2 objectAtIndex:row];
    
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  
    return [_pickValue2 count];


}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    /*
    NSString *title;
    title = [@"" stringByAppendingFormat:@"%d",row];
    
    return title;
     */
    return [_pickValue2 objectAtIndex:row];
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}



- (IBAction)exitkeyboard:(id)sender {
    
     [sender resignFirstResponder];
}

- (IBAction)TouchOutside:(id)sender {
       [self.view endEditing:YES];
}

-(void)dismissKeyboard {
    [_FavAsso resignFirstResponder];
}

- (BOOL)shouldAutorotate
{
    return NO;
}




@end
