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

@end
