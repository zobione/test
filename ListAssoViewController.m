//
//  ListAssoViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 24/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "ListAssoViewController.h"
#import "HomeViewController.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>

@interface ListAssoViewController ()

@end

@implementation ListAssoViewController

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = @"Association";
        self.textKey = @"name";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [super viewDidLoad];
    

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:simpleTableIdentifier];
    }
    
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [object objectForKey:@"Nom"];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //envoie de donnée au serveur
    //Code pour sauvegarder l'association favorite
    
    
    
    
    NSLog(@"touch");
    NSArray *Objects = self.objects;
    PFObject *Asso  = [Objects objectAtIndex:indexPath.row];
    NSLog(@"%@",Asso[@"Nom"]);
    
    

    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Mise à jour";
    [hud show:YES];
    
    PFQuery *query= [PFUser query];
    [query whereKey:@"username" equalTo: [[PFUser currentUser]username]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
    object[@"Association"] = Asso;

   

    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [hud hide:YES];
            
            if (!error) {
                // Show success message
                /*
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Changement effectués!" message:@"Votre association à bien été mise à jour" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                */
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
                HomeViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Tuto"];
                [self presentViewController:lvc animated:YES completion:nil];
                
                
                //[self performSegueWithIdentifier:@"UpdateAsso" sender:sender];
                
                // Dismiss the controller
                //[self dismissViewControllerAnimated:YES completion:nil];
                
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de chargement..." message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }];
    }];

    
}

- (BOOL)shouldAutorotate
{
    return NO;
}


@end
