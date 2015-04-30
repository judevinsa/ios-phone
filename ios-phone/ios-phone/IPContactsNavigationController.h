//
//  IPContactsNavigationController.h
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface IPContactsNavigationController : UINavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController managedObjectContext:(NSManagedObjectContext *)managedObjecContext;
@end
