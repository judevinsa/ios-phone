//
//  IPCallsTableViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import "IPCallsTableViewController.h"
#import "IPCallTableViewCell.h"

@interface IPCallsTableViewController () {
    NSMutableArray * _callList;

    // With Contact API
    ABAddressBookRef _addressBook;
    NSArray *  _contactList;
    NSMutableArray * _notMissedCalls;
    NSMutableArray * _notMissedIndexPath;
}

- (void)_initialization;
@end

static NSString * sCellIdentifier = @"callsCellIdentifier";

@implementation IPCallsTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _notMissedCalls = [[NSMutableArray alloc] init];
        _notMissedIndexPath = [[NSMutableArray alloc] init];

        // Method with contact API
        CFErrorRef abError;
        _addressBook = ABAddressBookCreateWithOptions(NULL, &abError);
        _contactList = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(_addressBook, NULL, kABPersonLastNameProperty);
        [self _initialization];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Calls";
    [_callsTableView registerNib:[UINib nibWithNibName:@"IPCallTableViewCell" bundle:nil] forCellReuseIdentifier:sCellIdentifier];
    [_filterSegmentedControl addTarget:self action:@selector(segmentedControlSwitched:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _callList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isMissedCall = [[_callList[indexPath.row] valueForKey:@"missed"] boolValue];
    IPCallTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sCellIdentifier forIndexPath:indexPath];

    ABRecordRef contact = (__bridge ABRecordRef)([_callList[indexPath.row] valueForKey:@"contact"]);
    cell.contactFirstNameLabel.text = (__bridge NSString *)ABRecordCopyValue(contact, kABPersonFirstNameProperty);
    cell.contactLastNameLabel.text = (__bridge NSString *)ABRecordCopyValue(contact, kABPersonLastNameProperty);
    cell.dateLabel.text = [_callList[indexPath.row] valueForKey:@"date"];

    if (isMissedCall) {
        cell.contactFirstNameLabel.textColor = [UIColor redColor];
        cell.contactLastNameLabel.textColor = [UIColor redColor];
        cell.dateLabel.textColor = [UIColor redColor];
    } else {
        [_notMissedCalls addObject:_callList[indexPath.row]];
        [_notMissedIndexPath addObject:indexPath];
    }

    return cell;
}


#pragma mark - Action Handlers

- (void)segmentedControlSwitched:(id)sender {
    if (_filterSegmentedControl.selectedSegmentIndex ==  0) {
        for (NSDictionary * call in _notMissedCalls) {
            [_callList insertObject:call atIndex:[[call valueForKey:@"index"] integerValue]];
        }
        [_callsTableView beginUpdates];
        [_callsTableView reloadRowsAtIndexPaths:_notMissedIndexPath withRowAnimation:UITableViewRowAnimationFade];
        [_callsTableView endUpdates];

    } else if (_filterSegmentedControl.selectedSegmentIndex == 1) {
        for (NSDictionary * call in _notMissedCalls) {
            [_callList removeObjectAtIndex:[[call valueForKey:@"index"] integerValue]];
        }
        [_callsTableView beginUpdates];
        [_callsTableView deleteRowsAtIndexPaths:_notMissedIndexPath withRowAnimation:UITableViewRowAnimationFade];
        [_callsTableView endUpdates];
    }
}

#pragma mark - Test

- (void)_initialization {
    _callList = [[NSMutableArray alloc] initWithObjects:
                 @{@"index": @0, @"contact": _contactList[1], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:1222334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": [NSNumber numberWithBool:YES]},
                 @{@"index": @1, @"contact": _contactList[2], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:12334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": [NSNumber numberWithBool:YES]},
                 @{@"index": @2, @"contact": _contactList[1], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:1255334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": [NSNumber numberWithBool:NO]},
                 @{@"index": @3, @"contact": _contactList[3], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:32334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": [NSNumber numberWithBool:YES]},
                 nil];
    return;
}

@end
