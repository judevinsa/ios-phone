//
//  IPDialerCollectionViewCell.m
//  ios-phone
//
//  Created by Julien Rollet on 06/05/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPDialerCollectionViewCell.h"

@implementation IPDialerCollectionViewCell

- (void)setDialerNumberText:(NSString *)numberText touchUpSelector:(SEL)touchUpSelector {
    if (!_dialerNumberButton) {
        _dialerNumberButton = [[UIButton alloc] init];
        _dialerNumberButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_dialerNumberButton setTitle:numberText forState:UIControlStateNormal];
        [_dialerNumberButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_dialerNumberButton setTintColor:[UIColor redColor]];
        _dialerNumberButton.layer.borderWidth = 1.0f;
        _dialerNumberButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _dialerNumberButton.layer.cornerRadius = [_dialerNumberSize floatValue] / 2.0f;
        [self.contentView addSubview:_dialerNumberButton];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dialerNumberButton(size)]|" options:0 metrics:@{@"size":_dialerNumberSize} views:NSDictionaryOfVariableBindings(_dialerNumberButton)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dialerNumberButton(size)]|" options:0 metrics:@{@"size":_dialerNumberSize} views:NSDictionaryOfVariableBindings(_dialerNumberButton)]];
        [_dialerNumberButton addTarget:_delegate action:touchUpSelector forControlEvents:UIControlEventTouchUpInside];
        [_dialerNumberButton addTarget:self action:@selector(touchInDisplay:) forControlEvents:UIControlEventTouchDown];
        [_dialerNumberButton addTarget:self action:@selector(touchUpDisplay:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [_dialerNumberButton setTitle:numberText forState:UIControlStateNormal];
    }
}

#pragma mark - Action Handlers 

// Visual Overlay when touched

- (void)touchInDisplay:(id)sender {
    _dialerNumberButton.backgroundColor = [UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:0.5f];
    [_dialerNumberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)touchUpDisplay:(id)sender {
    _dialerNumberButton.backgroundColor = [UIColor clearColor];
    [_dialerNumberButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

@end
