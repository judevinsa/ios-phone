//
//  IPDialerCollectionViewCell.h
//  ios-phone
//
//  Created by Julien Rollet on 06/05/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPDialerCollectionViewCell : UICollectionViewCell

- (void)setDialerNumberText:(NSString *)numberText;

@property (nonatomic) UIButton * dialerNumberButton;
@property (nonatomic) id delegate;
@property (nonatomic) NSNumber * dialerNumberSize;
@end
