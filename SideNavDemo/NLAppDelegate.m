//
//  NLAppDelegate.m
//  SideNavDemo
//
//  Created by 陈 凯 on 13-2-27.
//  Copyright (c) 2013年 Nono. All rights reserved.
//

#import "NLAppDelegate.h"
#import "NLSideNavViewController.h"
#import "NLNavRootViewController.h"
#import "NLLeftViewController.h"
@implementation NLAppDelegate

@synthesize side_nav;
- (void)dealloc
{
    [_window release];
    [side_nav release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    NLNavRootViewController *navRoot = [[NLNavRootViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:navRoot];
    [navRoot release];
    
   side_nav = [[NLSideNavViewController alloc] initWithRootView:nav];
    [nav release];
    
    NLLeftViewController *lvc = [[NLLeftViewController alloc] init];
    NLLeftViewController *rvc = [[NLLeftViewController alloc] init];

    [side_nav setLeftVC:lvc];
    [side_nav setRightVC:rvc];
    [lvc release];
    [rvc release];
    [self.window setRootViewController:side_nav];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
