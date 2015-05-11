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
    if (!_dialerNumberLabel) {
        _dialerNumberLabel = [[UILabel alloc] init];
        _dialerNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dialerNumberLabel.text = numberText;
        _dialerNumberLabel.textColor = [UIColor lightGrayColor];
        _dialerNumberLabel.textAlignment = NSTextAlignmentCenter;
        _dialerNumberLabel.layer.borderWidth = 1.0f;
        _dialerNumberLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _dialerNumberLabel.layer.cornerRadius = [_dialerNumberSize floatValue] / 2.0f;
        [self.contentView addSubview:_dialerNumberLabel];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dialerNumberLabel(size)]|" options:0 metrics:@{@"size":_dialerNumberSize} views:NSDictionaryOfVariableBindings(_dialerNumberLabel)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dialerNumberLabel(size)]|" options:0 metrics:@{@"size":_dialerNumberSize} views:NSDictionaryOfVariableBindings(_dialerNumberLabel)]];

        // We then set the selectedBackgroundView
        UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.frame];
        selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
        selectedBackgroundView.layer.cornerRadius = [_dialerNumberSize floatValue] / 2.0f;
        [self setSelectedBackgroundView:selectedBackgroundView];
    } else {
        _dialerNumberLabel.text = numberText;
    }
}
@end
