//
//  IPDialerViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPDialerViewController.h"

@interface IPDialerViewController () {
    NSArray * buttonLabels;
}

@end

@implementation IPDialerViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        buttonLabels = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"*", @"0", @"#", @"+", @"Call", @"<-"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dialerCollectionView.backgroundColor = [UIColor whiteColor];
    [_dialerCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionID"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionID" forIndexPath:indexPath];
    UIButton * button = [[UIButton alloc] init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:buttonLabels[indexPath.row] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    button.layer.cornerRadius = 25.0f;
    [cell.contentView addSubview:button];
    [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button(50)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
    [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button(50)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
    return cell;
}

@end
