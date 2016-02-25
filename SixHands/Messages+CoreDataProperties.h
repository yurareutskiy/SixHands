//
//  Messages+CoreDataProperties.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/23/16.
//  Copyright © 2016 Styleru. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Messages.h"

NS_ASSUME_NONNULL_BEGIN

@interface Messages (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSNumber *id_conversation;
@property (nullable, nonatomic, retain) NSNumber *id_receiver;
@property (nullable, nonatomic, retain) NSNumber *id_sender;
@property (nullable, nonatomic, retain) NSString *text;

@end

NS_ASSUME_NONNULL_END
