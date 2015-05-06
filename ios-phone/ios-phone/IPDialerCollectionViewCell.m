//
//  IPDialerCollectionViewCell.m
//  ios-phone
//
//  Created by Julien Rollet on 06/05/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPDialerCollectionViewCell.h"

@implementation IPDialerCollectionViewCell

- (void)setDialerNumberText:(NSString *)numberText {
    if (!_dialerNumberButton) {
        _dialerNumberButton = [[UIButton alloc] init];
        _dialerNumberButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_dialerNumberButton setTitle:numberText forState:UIControlStateNormal];
        [_dialerNumberButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _dialerNumberButton.layer.borderWidth = 1.0f;
        _dialerNumberButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _dialerNumberButton.layer.cornerRadius = [_dialerNumberSize floatValue] / 2.0f;
        [self.contentView addSubview:_dialerNumberButton];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dialerNumberButton(size)]|" options:0 metrics:@{@"size":_dialerNumberSize} views:NSDictionaryOfVariableBindings(_dialerNumberButton)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dialerNumberButton(size)]|" options:0 metrics:@{@"size":_dialerNumberSize} views:NSDictionaryOfVariableBindings(_dialerNumberButton)]];
        [_dialerNumberButton addTarget:_delegate action:@selector(updateTextViewWithPressedButton:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [_dialerNumberButton setTitle:numberText forState:UIControlStateNormal];
    }
}

@end
