//
//  AppDelegate.m
//  Parse+Storyboard
//
//  Created by Juan Figuera on 9/23/12.
//  Copyright (c) 2012 Juan Figuera. All rights reserved.
//

#import "AppDelegate.h"
#import "DefaultSettingsViewController.h"
#import <AdColony/AdColony.h>

@implementation AppDelegate

@synthesize alertTime, notifyAlarm;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // ****************************************************************************
    // Parse initialization
    // [Parse setApplicationId:@"APPLICATION_ID" clientKey:@"CLIENT_KEY"];
    [Parse setApplicationId:@"wJTummvxtYMMaRj9121VzzCw5NnMusBKxDaBCuiN" clientKey:@"dL9ctDvLuEEFYc1JwwAB05HJNbq1CQMdOkWVOnTE"];
    // ****************************************************************************
    
    // Override point for customization after application launch.
    
    /*
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor clearColor];
    */
    
    [AdColony configureWithAppID:@"appd8c3013df239403b8b" zoneIDs:@[@"vza993a2ac11ba445c9e"] delegate:nil logging:YES];
    
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];

    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    // Stop updating locations while in the background.

    //[defaultSettingsViewController.locationManager stopUpdatingLocation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // Start updating locations when the app returns to the foreground.

    NSLog(@"Active");

    

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    alertTime = [NSDate dateWithTimeIntervalSinceNow:604800];
    UIApplication* app = [UIApplication sharedApplication];
    notifyAlarm = [[UILocalNotification alloc]
                                        init];
    if (notifyAlarm)
    {
        notifyAlarm.fireDate = alertTime;
        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
        notifyAlarm.repeatInterval = 0;
        notifyAlarm.soundName = @"bell_tree.mp3";
        notifyAlarm.alertBody = @"Cela fait une semaine que nous ne vous avons pas vu! Venez donnez à votre asso préférée!!";
        [app scheduleLocalNotification:notifyAlarm];
    }
    
     NSLog(@"inactive");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetParam" object:nil];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     [[UIApplication sharedApplication] cancelAllLocalNotifications];
     NSLog(@"Active1");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshView" object:nil];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
