//
//  GetAssoViewController.h
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 23/02/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import <Parse/Parse.h>

@interface GetAssoViewController : PFQueryTableViewController

@property (strong, nonatomic) PFObject *Asso;
@property (nonatomic, retain) NSString *IDAsso;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
