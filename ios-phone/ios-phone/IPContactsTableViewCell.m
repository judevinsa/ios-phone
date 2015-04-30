//
//  IPContactsTableViewCell.m
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import "IPContactsTableViewCell.h"

@implementation IPContactsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _firstNameLabel.text = @"";
    _lastNameLabel.text = @"";
}

@end
