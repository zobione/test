//
//  TutoViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 14/04/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "SMPageControl.h"

@interface TutoViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    CGPoint offset;
}

@property (weak, nonatomic) IBOutlet UIButton *End;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) UIView *controls;

- (IBAction)test:(id)sender;
@property (weak, nonatomic) IBOutlet SMPageControl *pageControl1;


@end
