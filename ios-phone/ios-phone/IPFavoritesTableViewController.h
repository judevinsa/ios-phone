//
//  IPFavoritesTableViewController.h
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPFavoritesTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView * favoritesTableView;
@end
