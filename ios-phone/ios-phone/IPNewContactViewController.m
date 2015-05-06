//
//  IPNewContactViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 04/05/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import "IPNewContactViewController.h"

@interface IPNewContactViewController ()

@end

@implementation IPNewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add a contact";

    [_phoneTextField setKeyboardType:UIKeyboardTypePhonePad];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTouched:)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(confirmNewContact:)]];
}

#pragma mark - Action handlers

- (void)confirmNewContact:(id)sender {
    if (_firstNameTextField.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error in contact saving." message:@"First Name missing" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    } else if (_lastNameTextField.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error in contact saving." message:@"Last Name missing" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    } else if (_phoneTextField.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error in contact saving." message:@"Phone missing" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    } else {
        CFErrorRef error;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        ABRecordRef newContact = ABPersonCreate();
        ABRecordSetValue(newContact, kABPersonFirstNameProperty, (__bridge CFTypeRef)_firstNameTextField.text, &error);
        ABRecordSetValue(newContact, kABPersonLastNameProperty, (__bridge CFTypeRef)_lastNameTextField.text, &error);
        ABMutableMultiValueRef multiphone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multiphone, (__bridge CFTypeRef)_phoneTextField.text, kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(newContact, kABPersonPhoneProperty, multiphone, &error);
        ABAddressBookAddRecord(addressBook, newContact, &error);
        ABAddressBookSave(addressBook, &error);
        if (error) {
            CFStringRef stringOfError = CFErrorCopyDescription(error);
            NSLog(@"Contact not saved : error %@", stringOfError);
        }
    }

}

- (void)cancelButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
