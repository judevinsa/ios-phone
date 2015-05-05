//
//  IPCallTableViewCell.h
//  ios-phone
//
//  Created by Julien Rollet on 04/05/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPCallTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel * contactFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel * contactLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel * dateLabel;
@property (nonatomic) BOOL isMissedCall;
@end
