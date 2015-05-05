 //
//  IPNewContactViewController.h
//  ios-phone
//
//  Created by Julien Rollet on 04/05/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPNewContactViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton * addButton;
@property (weak, nonatomic) IBOutlet UIButton * cancelButton;
@property (weak, nonatomic) IBOutlet UITextField * phoneTextField;
@end
