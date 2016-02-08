//
//  Users.h
//  SixHands
//
//  Created by Anton Scherbakov on 08/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Users : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (instancetype)initUserWithFirstName:(NSString*)firstName LastName:(NSString*)lastName userID:(NSNumber*)id Email:(NSString*)email Phone:(NSString*)phone PhotoURL:(NSString*)photoURL Token:(NSString*)token socType:(NSString*)socType socID:(NSNumber*)socID;

@end

NS_ASSUME_NONNULL_END

#import "Users+CoreDataProperties.h"
