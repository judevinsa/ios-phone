//
//  IPDialerViewController.h
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPDialerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton * addContactButton;
@property (weak, nonatomic) IBOutlet UIButton * deleteButton;
@property (weak, nonatomic) IBOutlet UIButton * callButton;
@property (weak, nonatomic) IBOutlet UICollectionView * dialerCollectionView;
@property (weak, nonatomic) IBOutlet UITextView * dialerTextView;
@end
