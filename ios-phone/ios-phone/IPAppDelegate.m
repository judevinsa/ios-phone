//
//  AppDelegate.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//
#import <CoreData/CoreData.h>

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

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - AppDelegate

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
    IPContactsNavigationController * contactsNavigationController = [[IPContactsNavigationController alloc] initWithRootViewController:contactsTableViewController managedObjectContext:[self managedObjectContext]];

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



#pragma mark - Core Data auto generated code

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AppModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ios-phone.sqlite"];

    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.

         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.

         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.

         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]

         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}

         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.

         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
