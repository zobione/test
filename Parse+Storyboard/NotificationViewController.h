//
//  NotificationViewController.h
//  AdUnLock
//
//  Created by Emilien Sanchez on 13/03/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import <Parse/Parse.h>

@interface NotificationViewController : PFQueryTableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, retain) NSString *text;
@end
