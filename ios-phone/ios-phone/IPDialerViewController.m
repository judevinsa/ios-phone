//
//  IPDialerViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPDialerViewController.h"
#import "IPNewContactViewController.h"

@interface IPDialerViewController () {
    NSArray * _buttonLabels;
}

@end

static NSString * sCellIdentifier = @"collectionID";

@implementation IPDialerViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _buttonLabels = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"*", @"0", @"#", @"+", @"Call", @"<-"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dialerCollectionView.backgroundColor = [UIColor whiteColor];
    // TODO: use static nsstring
    [_dialerCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:sCellIdentifier];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _buttonLabels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:sCellIdentifier forIndexPath:indexPath];
    UIButton * button = [[UIButton alloc] init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:_buttonLabels[indexPath.row] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    button.layer.cornerRadius = 30.0f;
    [cell.contentView addSubview:button];
    [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button(60)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
    [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button(60)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
    [button addTarget:self action:@selector(updateTextViewWithPressedButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


#pragma mark - Action Handlers

- (void)updateTextViewWithPressedButton:(id)sender {
    if ([[[sender titleLabel] text] isEqualToString:@"<-"]){
        if (_dialerTextView.text.length > 0) {
            _dialerTextView.text = [_dialerTextView.text substringToIndex:(_dialerTextView.text.length - 1)];
        }
    } else if ([[[sender titleLabel] text] isEqualToString:@"+"]) {
        IPNewContactViewController * newContactViewController = [[IPNewContactViewController alloc] init];
        UINavigationController * newContactNavigationController = [[UINavigationController alloc] initWithRootViewController:newContactViewController];
        [self presentViewController:newContactNavigationController animated:YES completion:nil];

    } else if ([[[sender titleLabel] text] isEqualToString:@"Call"]) {

    } else {
        _dialerTextView.text = [_dialerTextView.text stringByAppendingString:[[sender titleLabel] text]];
    }
}
@end
