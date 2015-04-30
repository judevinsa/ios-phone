//
//  IPContactsNavigationController.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPContactsNavigationController.h"
#import "IPContact.h"

@interface IPContactsNavigationController () {
    NSArray * _contactList;
}

@end

@implementation IPContactsNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController managedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        if (managedObjectContext) {
            NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"IPContact" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entityDescription];
            NSError * error;
            _contactList = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
            if (error) {
                NSLog(@"%@\n",error);
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
