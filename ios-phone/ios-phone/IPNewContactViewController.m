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
    // Do any additional setup after loading the view from its nib.
    [_cancelButton addTarget:self action:@selector(cancelButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Action handlers

- (void)cancelButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
