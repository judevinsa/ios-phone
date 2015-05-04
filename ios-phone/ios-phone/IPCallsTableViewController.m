//
//  IPCallsTableViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import "IPCallsTableViewController.h"

@interface IPCallsTableViewController () {
    NSArray * _callList;

    // With Contact API
    ABAddressBookRef _addressBook;
    NSArray *  _contactList;
}

- (void)_initialization;
@end

static NSString * sCellIdentifier = @"callsCellIdentifier";

@implementation IPCallsTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        // Method with contact API
        CFErrorRef abError;
        _addressBook = ABAddressBookCreateWithOptions(NULL, &abError);
        _contactList = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(_addressBook, NULL, kABPersonLastNameProperty);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Calls";


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

- (void)_initialization {
    _callList = [[NSArray alloc] initWithObjects:
                 @{@"contact": _contactList[1], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:1222334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": @YES},
                 @{@"contact": _contactList[2], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:12334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": @YES},
                 @{@"contact": _contactList[1], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:1255334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": @NO},
                 nil];
    return;
}

@end
