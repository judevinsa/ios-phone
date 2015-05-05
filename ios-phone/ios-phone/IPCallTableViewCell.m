//
//  IPCallTableViewCell.m
//  ios-phone
//
//  Created by Julien Rollet on 04/05/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPCallTableViewCell.h"

@implementation IPCallTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareForReuse {
    _contactFirstNameLabel.text = @"";
    _contactLastNameLabel.text = @"";
    _dateLabel.text = @"";
}

- (void)setIsMissedCall:(BOOL)isMissedCall {
    _isMissedCall = isMissedCall;
    if (isMissedCall) {
        _contactFirstNameLabel.textColor = [UIColor redColor];
        _contactLastNameLabel.textColor = [UIColor redColor];
        _dateLabel.textColor = [UIColor redColor];
    } else {
        _contactFirstNameLabel.textColor = [UIColor blackColor];
        _contactLastNameLabel.textColor = [UIColor blackColor];
        _dateLabel.textColor = [UIColor blackColor];
    }
}

@end
