//
//  ContactsTableViewController.h
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface IPContactsTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

// Outlets
@property (weak, nonatomic) IBOutlet UITableView * contactsTableView;

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjecContext;
@end
