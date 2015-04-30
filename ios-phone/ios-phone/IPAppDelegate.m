//
//  AppDelegate.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPAppDelegate.h"
#import "IPFavoritesNavigationController.h"
#import "IPFavoritesTableViewController.h"
#import "IPCallsNavigationController.h"
#import "IPCallsTableViewController.h"
#import "IPContactsNavigationController.h"
#import "IPContactsTableViewController.h"
#import "IPDialerViewController.h"

@interface IPAppDelegate ()

@end

@implementation IPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // We first define the tabBarController
    UITabBarController * mainTabBarController = [[UITabBarController alloc] init];

    // Then the views relative to the first tab
    IPFavoritesTableViewController * favoritesTableViewController = [[IPFavoritesTableViewController alloc] init];
    IPFavoritesNavigationController * favoritesNavigationController = [[IPFavoritesNavigationController alloc] initWithRootViewController:favoritesTableViewController];

    // Then the views relative to the second tab
    IPCallsTableViewController * callsTableViewController = [[IPCallsTableViewController alloc] init];
    IPCallsNavigationController * callsNavigationController = [[IPCallsNavigationController alloc] initWithRootViewController:callsTableViewController];

    // Then the views relative to the third tab
    IPContactsTableViewController * contactsTableViewController = [[IPContactsTableViewController alloc] init];
    IPContactsNavigationController * contactsNavigationController = [[IPContactsNavigationController alloc] initWithRootViewController:contactsTableViewController];

    // Then the views relative to the fourth tab
    IPDialerViewController * dialerViewController = [[IPDialerViewController alloc] init];

    // We set the tabBarItems
    favoritesNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Favorites" image:nil tag:0];
    callsNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Calls" image:nil tag:1];
    contactsNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Contacts" image:nil tag:2];
    dialerViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Dialer" image:nil tag:3];


    // We set the controllers that will go in the tabs
    NSArray * tabItems = [NSArray arrayWithObjects:favoritesNavigationController, callsNavigationController, contactsNavigationController, dialerViewController, nil];
    [mainTabBarController setViewControllers:tabItems animated:YES];

    // We finally say that the tabBar is the main controller
    _window.rootViewController = mainTabBarController;

    [_window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
