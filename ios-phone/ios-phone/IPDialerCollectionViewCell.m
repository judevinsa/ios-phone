//
//  IPDialerCollectionViewCell.m
//  ios-phone
//
//  Created by Julien Rollet on 06/05/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPDialerCollectionViewCell.h"

@interface IPDialerCollectionViewCell () {
    UIView * _selectedBackgroundView;
}

@end

@implementation IPDialerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _dialerNumberLabel = [[UILabel alloc] init];
        _dialerNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dialerNumberLabel.textColor = [UIColor lightGrayColor];
        _dialerNumberLabel.textAlignment = NSTextAlignmentCenter;
        _dialerNumberLabel.layer.borderWidth = 1.0f;
        _dialerNumberLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];

        [self.contentView addSubview:_dialerNumberLabel];
        _dialerNumberLabel.layer.cornerRadius = frame.size.width / 2.0f;
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dialerNumberLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_dialerNumberLabel)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dialerNumberLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_dialerNumberLabel)]];

        // We then set the selectedBackgroundView
        _selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.frame];
        _selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
        _selectedBackgroundView.layer.cornerRadius =  frame.size.width / 2.0f;
        [self setSelectedBackgroundView:_selectedBackgroundView];
    }
    return self;
}

- (void)prepareForReuse {
    _dialerNumberLabel.text = @"";
}

@end
