//
//  ViewController.h
//  Gimmi
//
//  Created by Emilien Sanchez on 01/07/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "CPFQueryCollectionViewController.h"
#import <AdColony/AdColony.h>

@interface ViewController : CPFQueryCollectionViewController <AdColonyAdDelegate, UIGestureRecognizerDelegate>
{
    CGSize CellSize;
    CGRect ImageViewSize;
    CGRect Labelsize;
    NSTimer *levelTimer;
    BOOL reload;
    NSMutableArray *Objects;
    PFObject *Asso;
    PFObject *Asso2;
    UIView *overlay;
    UILabel *label;
    CGPoint offset;
}


- (void)levelTimerCallback:(NSTimer *)timer;

@end
