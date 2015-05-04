//
//  ContactsTableViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//
#import <AddressBook/AddressBook.h>
#import "IPContactsTableViewController.h"
#import "IPContactsTableViewCell.h"
#import "IPContact.h"
#import "IPNewContactViewController.h"

@interface IPContactsTableViewController () {
    // With CoreData
    //NSArray * _contactList;

    // With Contact API
    ABAddressBookRef _addressBook;
    CFArrayRef _contactList;
}

@end

static NSString * sCellIdentifier = @"contactsCellIdentifier";

@implementation IPContactsTableViewController

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    self = [super init];
    if (self) {
        if (managedObjectContext) {

            // Method with Core Data
//            NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
//            NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"IPContact" inManagedObjectContext:managedObjectContext];
//            [fetchRequest setEntity:entityDescription];
//            NSError * error;
//            _contactList = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
//            if (error) {
//                NSLog(@"%@\n",error);
//            }


            // Method with contact API
            CFErrorRef abError;
            _addressBook = ABAddressBookCreateWithOptions(NULL, &abError);

            __block BOOL accessGranted = NO;

            if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
                dispatch_semaphore_t sema = dispatch_semaphore_create(0);

                ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool granted, CFErrorRef error) {
                    accessGranted = granted;
                    dispatch_semaphore_signal(sema);
                });

                dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            }
            else { // we're on iOS 5 or older
                accessGranted = YES;
            }

            _contactList = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(_addressBook, NULL, kABPersonLastNameProperty);
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Contacts";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAContact:)];
    [_contactsTableView registerNib:[UINib nibWithNibName:@"IPContactsTableViewCell" bundle:nil] forCellReuseIdentifier:sCellIdentifier];
}



#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ABAddressBookGetPersonCount(_addressBook);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IPContactsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sCellIdentifier forIndexPath:indexPath];

    // With CoreData
    //IPContact * contact = _contactList[indexPath.row];

    // With contact API
    ABRecordRef contact = CFArrayGetValueAtIndex(_contactList, indexPath.row);
    cell.firstNameLabel.text = (__bridge NSString *)ABRecordCopyValue(contact, kABPersonFirstNameProperty);
    cell.lastNameLabel.text = (__bridge NSString *)ABRecordCopyValue(contact, kABPersonLastNameProperty);
    return cell;
}

#pragma mark - Action Handlers

- (void)addAContact:(id)sender {
    IPNewContactViewController * newContactViewController = [[IPNewContactViewController alloc] init];
    [self presentViewController:newContactViewController animated:YES completion:nil];
}

@end
