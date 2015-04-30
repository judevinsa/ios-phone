//
//  ContactsTableViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPContactsTableViewController.h"
#import "IPContactsTableViewCell.h"
#import "IPContact.h"

@interface IPContactsTableViewController () {
    NSArray * _contactList;
}

@end

static NSString * sCellIdentifier = @"contactsCellIdentifier";

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAContact:)];
    [_contactsTableView registerNib:[UINib nibWithNibName:@"IPContactsTableCellView" bundle:nil] forCellReuseIdentifier:sCellIdentifier];
}



#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contactList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IPContactsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sCellIdentifier forIndexPath:indexPath];
    IPContact * contact = _contactList[indexPath.row];
    cell.firstNameLabel.text = contact.firstName;
    cell.lastNameLabel.text = contact.lastName;
    return cell;
}

#pragma mark - Action Handlers

- (void)addAContact:(id)sender {

}

@end
