//
//  ViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 01/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "ViewController.h"
#import "HomeCollecViewController.h"
#import "ExplicationViewController.h"
#import "FinVideoViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    int screenHeight = self.view.bounds.size.height;
    if (screenHeight<500) {
        //Show the UIImage for iPhone 4.
        offset = CGPointMake(0, 20);
    }
    else {
        //Show the UIImage for iPhone 5.
        offset = CGPointMake(0, 30);
    }

    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background2.png"]]];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    //NSLog(@"%D", self.view.frame.size.height);
    CellSize = CGSizeMake(self.view.frame.size.width/2 - 5, (self.view.frame.size.height-60-80)/4 );
    ImageViewSize = CGRectMake(CellSize.width/2 - (CellSize.height - 20 - 2)/2, 0, CellSize.height - 20 - 2, CellSize.height - 20 - 2);
    Labelsize = CGRectMake(4, ImageViewSize.size.height, CellSize.width - 8, 20);
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5; //seconds
    lpgr.delegate = self;
    [self.collectionView addGestureRecognizer:lpgr];

    levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    reload = true;
    Objects = [[NSMutableArray alloc] init];
    overlay = [[UIView alloc] init];
    [overlay setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+30)];
    [overlay setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.7]];
    label = [[UILabel alloc] init];
    label.numberOfLines =2;
    label.text = @"Plus de publicités... Merci de réessayer plus tard!";
    UIFont *yourFont2 = [UIFont fontWithName:@"Roboto-Medium" size:13];
    [label setFont:yourFont2];
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    [label setFrame:CGRectMake(0, self.view.frame.size.height/2 - 30, self.view.frame.size.width, 60)];
    label.textAlignment = UITextAlignmentCenter;
    [label setTextColor:[UIColor whiteColor]];
    
    [overlay removeFromSuperview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:@"refreshView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetParam:)
                                                 name:@"resetParam" object:nil];
    //[self Addoverlay];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForCollection
{
    //BOOL *q = true;
    NSString *t = @"x";
    PFQuery *query = [PFQuery queryWithClassName:@"Association"];
    [query whereKey:@"Description" equalTo:t];
    [query orderByAscending:@"Position"];
    return query;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CellSize;
}

-(void)collectionView:(UICollectionView *)collectionView2 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    //[self addCategorie:indexPath.row];
    NSLog(@"didselect %lD",(long)indexPath.row);
    Asso = [Objects objectAtIndex:indexPath.row];
    ADCOLONY_ZONE_STATUS t = [AdColony zoneStatusForZone:@"vza993a2ac11ba445c9e"];
    if (t == ADCOLONY_ZONE_STATUS_ACTIVE) {
        //do
        [AdColony playVideoAdForZone:@"vza993a2ac11ba445c9e" withDelegate:self];
        
        PFUser *user = [PFUser currentUser];
        PFObject *gameScore = [PFObject objectWithClassName:@"ClicPlay"];
        gameScore[@"Association"] = Asso;
        gameScore[@"User"] = user;
        [gameScore saveInBackground];
        
 
    } else {
        NSLog(@"Pas de video");
    }

    
}

# pragma mark - Collection View data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    
    [(UILabel *)[cell viewWithTag:1] setText:object[@"Nom"]];
    [(UILabel *)[cell viewWithTag:1] setFrame:Labelsize];
    [(UILabel *)[cell viewWithTag:1] setNumberOfLines:2];
    UIFont *yourFont = [UIFont fontWithName:@"Roboto-Light" size:13];
    [(UILabel *)[cell viewWithTag:1] setFont:yourFont];
    [(UILabel *)[cell viewWithTag:1] setAdjustsFontSizeToFitWidth:YES];
    //[(UILabel *)[cell viewWithTag:1] setLineBreakMode:NSLineBreakByWordWrapping];
    
    //UIFont *yourNewSameStyleFont = [label.font fontWithSize:14];
    
    //UIImage *image = [UIImage imageNamed:@"icon2.png"];
    PFFile *imageFile = [object objectForKey:@"LogoListeAssos"];
    NSData *imageData = [imageFile getData];
    UIImage *image2 = [UIImage imageWithData:imageData];
    [(UIImageView *)[cell viewWithTag:2] setImage:image2];
    [(UIImageView *)[cell viewWithTag:2] setFrame:ImageViewSize];
    
    //[cell setBackgroundColor:[UIColor redColor]];
    
    [Objects insertObject:object atIndex:indexPath.row];
    NSLog(@"%lu",(unsigned long)Objects.count);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake(320, 60);
    return headerSize;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
 
        if (reusableview==nil) {
            reusableview=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 10, 320, offset.y)];
        }
 
        
        UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, offset.y)];
        label2.text=[NSString stringWithFormat:@"Quelle sera votre bonne action aujourd'hui?"];
        //UIFont *yourNewSameStyleFont = [label.font fontWithSize:14];
        UIFont *yourNewSameStyleFont = [UIFont fontWithName:@"Roboto-Medium" size:15];
        label2.font = yourNewSameStyleFont;
        label2.textAlignment = UITextAlignmentCenter;
        [label2 setTextColor:[UIColor whiteColor]];
        [reusableview addSubview:label2];
        
        return reusableview;
    }
    return nil;
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{

    CGPoint tappedPoint = [gestureRecognizer locationInView:self.collectionView];
    NSIndexPath *tappedCellPath = [self.collectionView indexPathForItemAtPoint:tappedPoint];
    
    if (tappedCellPath)
    {
        //Display view
        PFObject *object = [Objects objectAtIndex:tappedCellPath.row];
        NSString *assoNom = object[@"Nom"];

        NSString *assoDescription = object[@"Description_Courte"];
        
        
        NSLog(@"long touch at index %lD", (long)tappedCellPath.row);
        NSLog(@"desc: %@ , nom %@", assoDescription, assoNom);
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        ExplicationViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Explication"];
        
        lvc.ExplicationAsso.text = assoDescription;
        lvc.AssoPass = object;
        [self presentViewController:lvc animated:YES completion:nil];
        
    }
    
}

- (void)levelTimerCallback:(NSTimer *)timer {
	//NSLog(@"Average input");
    if ([AdColony zoneStatusForZone:@"vza993a2ac11ba445c9e"] == ADCOLONY_ZONE_STATUS_ACTIVE) {
        //NSLog(@"OK");
        /*
        if (reload==true) {
            NSLog(@"OK");
            [self.collectionView reloadData];
            reload = NO;
            [self Removeoverlay];
        }
         */
        [self Removeoverlay];
        
    } else {
        NSLog(@"pas de pub");
        //reload = true;
        [self Addoverlay];
    }
}

-(void)onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneID
{
    NSLog(@"Ad finished");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    FinVideoViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Fin"];
    lvc.AssoPass = Asso;
    [self presentViewController:lvc animated:YES completion:nil];
    
    PFUser *user = [PFUser currentUser];
    PFObject *gameScore = [PFObject objectWithClassName:@"Visionnage"];
    gameScore[@"Association"] = Asso;
    gameScore[@"User"] = user;
    gameScore[@"Note"] = @"Adcolony2";
    [gameScore saveInBackground];
    Asso2 = nil;
    
}

-(void)Addoverlay
{
    //do
    if (reload == true) {
        [self.view addSubview:overlay];
        [overlay bringSubviewToFront:overlay];
        [overlay addSubview:label];
        reload = false;
    }


}

-(void)Removeoverlay
{
    if (reload == false) {
        [overlay removeFromSuperview];
        [label removeFromSuperview];
    }
    
    
}

-(void)refreshView:(NSNotification *) notification {
    
    //CODE TO REFRESH THE VIEW HERE
    NSLog(@"refresh");
    [self.collectionView reloadData];
    
    //[self viewDidLoad];

    
    
}

-(void)resetParam:(NSNotification *)notification{
    NSLog(@"reset");
    [overlay removeFromSuperview];
    [label removeFromSuperview];
    reload =true;
}

@end
