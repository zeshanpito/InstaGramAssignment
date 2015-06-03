//
//  AppDelegate.m
//  InstagramIntegration
//
//  Created by Zeshan Hayder on 29/05/2015.
//  Copyright (c) 2015 PITO. All rights reserved.
//

#import "AppDelegate.h"
#import "PIOPictureCollectionViewController.h"
#import "InstagramKit.h"
#import "PIOFlickrViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //PIOPictureCollectionViewController *mediaViewController = [PIOPictureCollectionViewController new];
    PIOFlickrViewController *flickerViewController = [PIOFlickrViewController new];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:flickerViewController];
//    self.navigationController.navigationBarHidden = YES;
    [self.window setRootViewController:self.navigationController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[InstagramEngine sharedEngine] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}


- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSString *scheme = [url scheme];
    NSLog(@"url scheme--> %@",scheme);
    if([@"InstagramIntegration" isEqualToString:scheme]) {
        // I don't recommend doing it like this, it's just a demo... I use an authentication
        // controller singleton object in my projects
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserAuthCallbackNotification" object:url userInfo:nil];
    }
    return YES;
}

@end
