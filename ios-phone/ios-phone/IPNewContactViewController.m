//
//  IPNewContactViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 04/05/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPNewContactViewController.h"

@interface IPNewContactViewController ()

@end

@implementation IPNewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add a contact";

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTouched:)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(confirmNewContact:)]];
}

#pragma mark - Action handlers

- (void)confirmNewContact:(id)sender {

}

- (void)cancelButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
