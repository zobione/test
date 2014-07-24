//
//  TutoViewController.m
//  Gimmi
//
//  Created by Emilien Sanchez on 14/04/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "TutoViewController.h"
#import "HomeViewController.h"

@interface TutoViewController ()

@end

@implementation TutoViewController
@synthesize pageViewController;
@synthesize controls;
@synthesize End;
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
    [super viewDidLoad];
    
    int screenHeight = self.view.bounds.size.height;
    if (screenHeight<500) {
        //Show the UIImage for iPhone 4.
        _pageTitles = @[@"", @"", @"", @""];
        _pageImages = @[@"tutop1i4.png", @"tutop2i4.png", @"tutop3i4.png", @"tutop4i4.png"];
        offset = CGPointMake(0, 0);
    }
    else {
        //Show the UIImage for iPhone 5.
        _pageTitles = @[@"", @"", @"", @""];
        _pageImages = @[@"tutop1.png", @"tutop2.png", @"tutop3.png", @"tutop4.png"];
        offset = CGPointMake(0, 30);
    }

	// Do any additional setup after loading the view.

    
    

    
    
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
  
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 37);
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [self.view addSubview:pageViewController.view];
    
    [self.pageViewController didMoveToParentViewController:self];
    
    [End setFrame:CGRectMake(End.frame.origin.x, self.view.frame.size.height - 50 - offset.y, End.frame.size.width, End.frame.size.height)];
    
    
    [self.view insertSubview:controls aboveSubview:pageViewController.view];
    [self.view bringSubviewToFront:self.End];
    
    self.pageControl1.numberOfPages = 4;
    [self.pageControl1 setPageIndicatorImage:[UIImage imageNamed:@"point"]];
	[self.pageControl1 setCurrentPageIndicatorImage:[UIImage imageNamed:@"point2"]];
    [self.pageControl1 addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [self.view bringSubviewToFront:self.pageControl1];
    [self.pageControl1 setCurrentImage:[UIImage imageNamed:@"point2"] forPage:0];
    [self.pageControl1 setFrame:CGRectMake(self.view.frame.size.width/2 - self.pageControl1.frame.size.width/2, self.view.frame.size.height - 100 - offset.y, self.pageControl1.frame.size.width, self.pageControl1.frame.size.height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    //NSLog(@"index %lu", (unsigned long)pageContentViewController.pageIndex);

    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    
    if ((index == 0) || (index == NSNotFound)) {
        [self turnPageRight:0];
        return nil;
        
    }
    NSLog(@"index -- %lu", (unsigned long)index);
    [self turnPageRight:index];
    index--;
    

    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{

    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
   
    NSLog(@"index ++ %lu", (unsigned long)index);
    if (index == NSNotFound) {
        [self turnPageleft:0];
        return nil;
    }
    [self turnPageleft:index];
    index++;
    
    if (index == [self.pageTitles count]) {
        [self turnPageleft:3];
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}





- (IBAction)test:(id)sender {
    NSLog(@"touch");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    HomeViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Root"];
    lvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:lvc animated:YES completion:nil];
    //[self transitionFromViewController:self toViewController:lvc duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{} completion:nil];

}

- (void)pageControl:(id)sender
{

    NSLog(@"Current Page (UIPageControl) : %i", self.pageControl1.currentPage);
}

- (void)spacePageControl:(SMPageControl *)sender
{
	NSLog(@"Current Page (SMPageControl): %li", (long)sender.currentPage);
}

-(void)turnPageleft:(NSInteger *)index
{
    if (index == 3) {
        [self.pageControl1 setCurrentPage:3];
    } else if (index == 2) {
        [self.pageControl1 setCurrentPage:2];
    } else if (index == 1) {
        [self.pageControl1 setCurrentPage:1];
    } else if (index == 0) {
        [self.pageControl1 setCurrentPage:0];
    }
}

-(void)turnPageRight:(NSInteger *)index
{
    if (index == 3) {
        [self.pageControl1 setCurrentPage:3];
    } else if (index == 2) {
        [self.pageControl1 setCurrentPage:2];
    } else if (index == 1) {
        [self.pageControl1 setCurrentPage:1];
    } else if (index == 0) {
        [self.pageControl1 setCurrentPage:0];
    }
}

@end
