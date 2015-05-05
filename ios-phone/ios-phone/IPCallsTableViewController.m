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
    NSMutableArray * _notMissedIndexPaths;
}

- (void)_initialization;
- (void)_updateNotMissedCalls;
@end

static NSString * sCellIdentifier = @"callsCellIdentifier";

@implementation IPCallsTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _notMissedCalls = [[NSMutableArray alloc] init];
        _notMissedIndexPaths = [[NSMutableArray alloc] init];

        // Method with contact API
        CFErrorRef abError;
        _addressBook = ABAddressBookCreateWithOptions(NULL, &abError);
        _contactList = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(_addressBook, NULL, kABPersonLastNameProperty);
        [self _initialization];
        [self _updateNotMissedCalls];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_callsTableView setContentOffset:CGPointMake(_callsTableView.contentOffset.x, _callsTableView.contentOffset.y - 62.0f)];
    [_callsTableView registerNib:[UINib nibWithNibName:@"IPCallTableViewCell" bundle:nil] forCellReuseIdentifier:sCellIdentifier];
    NSArray * filterItems = [NSArray arrayWithObjects:@"All", @"Missed", nil];

    _filterSegmentedControl = [[UISegmentedControl alloc] initWithItems:filterItems];
    _filterSegmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    _filterSegmentedControl.selectedSegmentIndex = 0;
    [_filterSegmentedControl addTarget:self action:@selector(segmentedControlSwitched:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 40.0f)];
    [self.navigationItem.titleView addSubview:_filterSegmentedControl];

    [self.navigationItem.titleView addConstraint:[NSLayoutConstraint constraintWithItem:_filterSegmentedControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.navigationItem.titleView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.navigationItem.titleView addConstraint:[NSLayoutConstraint constraintWithItem:_filterSegmentedControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.navigationItem.titleView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    [self.navigationItem.titleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_filterSegmentedControl(150)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_filterSegmentedControl)]];
    [self.navigationItem.titleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_filterSegmentedControl(25)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_filterSegmentedControl)]];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self _updateNotMissedCalls];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

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
    cell.isMissedCall = isMissedCall;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_callList removeObjectAtIndex:indexPath.row];
        [self _updateNotMissedCalls];
        [_callsTableView beginUpdates];
        [_callsTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        [_callsTableView endUpdates];
    }
}


#pragma mark - Action Handlers

- (void)segmentedControlSwitched:(id)sender {
    if (_filterSegmentedControl.selectedSegmentIndex ==  0) {
        for (NSDictionary * callAndIndexPath in _notMissedCalls) {
            [_callList insertObject:[callAndIndexPath valueForKey:@"call"] atIndex:[[callAndIndexPath valueForKey:@"indexPath"] row]];
        }
        [_callsTableView beginUpdates];
        [_callsTableView insertRowsAtIndexPaths:_notMissedIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [_callsTableView endUpdates];
    } else if (_filterSegmentedControl.selectedSegmentIndex == 1) {
        for (NSDictionary * callAndIndexPath in _notMissedCalls) {
            [_callList removeObjectAtIndex:[[callAndIndexPath valueForKey:@"indexPath"] row]];
        }
        [_callsTableView beginUpdates];
        [_callsTableView deleteRowsAtIndexPaths:_notMissedIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [_callsTableView endUpdates];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if (_callList.count || !editing) {
        [super setEditing:editing animated:animated];
        [_callsTableView setEditing:editing animated:YES];
    }
}

#pragma mark - Private Methods


- (void)_updateNotMissedCalls {
    [_notMissedCalls removeAllObjects];
    [_notMissedIndexPaths removeAllObjects];
    for (NSInteger i = 0; i < _callList.count; i++) {
        if (![[_callList[i] valueForKey:@"missed"] boolValue]) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [_notMissedCalls addObject:@{@"call": _callList[i], @"indexPath":indexPath}];
            [_notMissedIndexPaths addObject:indexPath];
        }
    }
}

- (void)_initialization {
    _callList = [[NSMutableArray alloc] initWithObjects:
                 @{@"contact": _contactList[1], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:1222334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": [NSNumber numberWithBool:YES]},
                 @{@"contact": _contactList[2], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:12334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": [NSNumber numberWithBool:YES]},
                 @{@"contact": _contactList[1], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:1255334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": [NSNumber numberWithBool:NO]},
                 @{@"contact": _contactList[3], @"date": [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:32334.0f] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle], @"missed": [NSNumber numberWithBool:YES]},
                 nil];
    return;
}

@end
