//
//  HomeCollecViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 01/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface HomeCollecViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView *overlay;
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *bouttonReveal;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@end
