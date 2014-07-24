//
//  NotificationViewController.m
//  AdUnLock
//
//  Created by Emilien Sanchez on 13/03/2014.
//  Copyright (c) 2014 Juan Figuera. All rights reserved.
//

#import "NotificationViewController.h"
#import "SWRevealViewController.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f


@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = @"Comment";
        self.textKey = @"name";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)viewDidLoad
{
  

    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75.0/255.0 green:193.0/255.0 blue:210.0/255.0 alpha:1]];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    /*
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
     */
    
    // Change button color
   // _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
     
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
    
    
    //cell.textLabel.text = [object objectForKey:@"Date"];
    //cell.detailTextLabel.text = [object objectForKey:@"texte"];
    
    
    //Recipe *recipe = [recipes objectAtIndex:indexPath.row];
    
    UILabel *titreLabel = (UILabel *)[cell viewWithTag:101];
    titreLabel.text = [object objectForKey:@"Titre"];
    //titreLabel.font =  [UIFont fontWithName:@"Roboto-Regular" size:17];
    

    UILabel *date = (UILabel *)[cell viewWithTag:102];
    date.text = [object objectForKey:@"Date"];
    //date.font =  [UIFont fontWithName:@"Roboto-Regular" size:11];
    
    
    UILabel *content = (UILabel *)[cell viewWithTag:103];
    content.text = [object objectForKey:@"texte"];
    //content.font =  [UIFont fontWithName:@"Roboto-Thin" size:11];
    
     
    CGRect updateFrame = content.frame;
    updateFrame.size.height = [content.text sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(222, 500)].height;
    content.frame = updateFrame;
    
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.objects.count) {
        return 50.0f;  //last cell
    }else{
        
        PFObject* update = [self.objects objectAtIndex:indexPath.row];
        NSString *text = [update objectForKey:@"texte"];
        return 40 + [text sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(222, 1000)].height;
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //envoie de donnée au serveur
    /*
     UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     cell.selected = TRUE;
     cell.accessoryType = UITableViewCellAccessoryCheckmark;
     if (data != self.checkedData) {
     self.checkedData = data;
     }
     [tableView reloadData];
     */


    
    
    
    //[self performSegueWithIdentifier:@"SendData" sender:self];
    
}
/*
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 if([segue.identifier isEqualToString:@"SendData"]){
 
 }
 }
 */



@end
