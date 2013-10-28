//
//  AppDelegate.m
//  APNsTutorial
//
//  Created by Bill on 13-10-21.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "AppDelegate.h"
#import "ProductsTableViewController.h"

@implementation AppDelegate
{
    ProductsTableViewController *controller;
}
@synthesize delegate;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"MarkoOne-Regular" size:24.0], UITextAttributeFont,
      [UIColor whiteColor], UITextAttributeTextColor,
      nil]];
    
    UINavigationController *navController = (UINavigationController *)[self.window rootViewController];
    controller = [[navController viewControllers] objectAtIndex:0];
    self.delegate = controller;
    
    if (launchOptions!=nil)
    {
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (userInfo!=nil)
        {
            if ([userInfo objectForKey:@"aps"]!=nil)
            {
                if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=nil) {
                    NSString *str = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
                    NSRange range = [str rangeOfString:@"ID="];
                    int productID = [[str substringFromIndex:range.length+range.location] intValue];
                    [self.delegate getNewProduc:productID];
                }
            }
            
        }
    }
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
    NSLog(@"applicationDidBecomeActive");
    if (!controller) {
        UINavigationController *navController = (UINavigationController *)[self.window rootViewController];
        controller = [[navController viewControllers] objectAtIndex:0];
        self.delegate = controller;
    }
    [delegate getAllPromotions];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"My token is %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to get token, error: %@", error);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Receive Remote Notification: %@", userInfo);
    
    NSLog(@"%@", userInfo);
    if ([userInfo objectForKey:@"aps"]!=nil)
    {
        if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=nil) {
            NSString *str = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
            NSRange range = [str rangeOfString:@"ID="];
            int productID = [[str substringFromIndex:range.length+range.location] intValue];
            [self.delegate getNewProduc:productID];
        }
    }
}

@end
