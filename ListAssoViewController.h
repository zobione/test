//
//  ListAssoViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 24/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <Parse/Parse.h>

@interface ListAssoViewController : PFQueryTableViewController

@property (strong, nonatomic) PFObject *Asso;
@property (nonatomic, retain) NSString *IDAsso;

@end
