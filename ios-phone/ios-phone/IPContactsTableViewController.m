//
//  ContactsTableViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPContactsTableViewController.h"

@interface IPContactsTableViewController () {
    NSArray * _contactList;
}

@end

@implementation IPContactsTableViewController

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    self = [super init];
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
    self.title = @"Contacts";
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
