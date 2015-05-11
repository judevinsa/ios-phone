//
//  IPDialerViewController.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPDialerViewController.h"
#import "IPNewContactViewController.h"
#import "IPDialerCollectionViewCell.h"

@interface IPDialerViewController () {
    NSArray * _buttonLabels;

    CGFloat _calculatedButtonSize;
}

- (void)_updateTextViewWithDialedText:(NSString *)dialedText;
@end
static NSString * sCellIdentifier = @"collectionID";

@implementation IPDialerViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _buttonLabels = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"*", @"0", @"#"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dialerCollectionView.backgroundColor = [UIColor whiteColor];
    [_dialerCollectionView registerClass:[IPDialerCollectionViewCell class] forCellWithReuseIdentifier:sCellIdentifier];

    CGFloat totalWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat totalHeight = [[UIScreen mainScreen] bounds].size.height;

    _calculatedButtonSize = 0.1f * totalHeight <= 60.0f ? 0.1f * totalHeight : 60.0f;
    CGFloat calculatedWidthMinusInsets = 2 * 20.0f + 3 * _calculatedButtonSize;

    CGFloat insetWidth = (totalWidth - calculatedWidthMinusInsets) / 2.0f;
    CGFloat contentInset = 0.77 * totalHeight - 40.0f - 5 * _calculatedButtonSize - 5 * 20.0f;
    contentInset = contentInset > 0.0f ? contentInset : 0.0f;
    [_dialerCollectionView setContentInset:UIEdgeInsetsMake(contentInset, insetWidth, 0.0f, insetWidth)];

    [_addContactButton addTarget:self action:@selector(presentNewContactView:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton addTarget:self action:@selector(deleteNumberInTextView:) forControlEvents:UIControlEventTouchUpInside];
    _callButton.layer.cornerRadius = _calculatedButtonSize / 2.0f;
    _callButton.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_callButton(size)]" options:0 metrics:@{@"size":[NSNumber numberWithFloat:_calculatedButtonSize]} views:NSDictionaryOfVariableBindings(_callButton)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_callButton(size)]" options:0 metrics:@{@"size":[NSNumber numberWithFloat:_calculatedButtonSize]} views:NSDictionaryOfVariableBindings(_callButton)]];
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_calculatedButtonSize, _calculatedButtonSize);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _buttonLabels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IPDialerCollectionViewCell * cell = (IPDialerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:sCellIdentifier forIndexPath:indexPath];
    cell.dialerNumberLabel.text = _buttonLabels[indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    IPDialerCollectionViewCell * cell = (IPDialerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self _updateTextViewWithDialedText:cell.dialerNumberLabel.text];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - Action Handlers

- (void)presentNewContactView:(id)sender {
    IPNewContactViewController * newContactViewController = [[IPNewContactViewController alloc] init];
    UINavigationController * newContactNavigationController = [[UINavigationController alloc] initWithRootViewController:newContactViewController];
    [self presentViewController:newContactNavigationController animated:YES completion:^{
        newContactViewController.phoneTextField.text = _dialerTextView.text;
    }];
}

- (void)deleteNumberInTextView:(id)sender {
    if (_dialerTextView.text.length > 0) {
        _dialerTextView.text = [_dialerTextView.text substringToIndex:(_dialerTextView.text.length - 1)];
    }
    if (_dialerTextView.text.length == 0) {
        _addContactButton.hidden = YES;
        _deleteButton.hidden = YES;
    }
}

- (void)_updateTextViewWithDialedText:(NSString *)dialedText {
    if (_dialerTextView.text.length == 0) {
        _addContactButton.hidden = NO;
        _deleteButton.hidden = NO;
    }
    _dialerTextView.text = [_dialerTextView.text stringByAppendingString:dialedText];
}
@end
