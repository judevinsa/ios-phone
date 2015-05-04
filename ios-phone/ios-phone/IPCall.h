//
//  IPCall.h
//  ios-phone
//
//  Created by Julien Rollet on 30/04/15.
//  Copyright (c) 2015 Julien Rollet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IPContact;

@interface IPCall : NSManagedObject

@property (nonatomic, retain) NSDate * callDate;
@property (nonatomic, retain) IPContact *caller;

@end
