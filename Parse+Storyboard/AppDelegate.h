//
//  AppDelegate.h
//  Parse+Storyboard
//
//  Created by Emilien Sanchez on 9/23/12.
//  Copyright (c) 2012 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDate *alertTime;
@property (strong, nonatomic) UILocalNotification  *notifyAlarm;

@end
