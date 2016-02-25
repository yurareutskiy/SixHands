//
//  Flats+CoreDataProperties.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/23/16.
//  Copyright © 2016 Styleru. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Flats.h"

NS_ASSUME_NONNULL_BEGIN

@interface Flats (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSDate *create_date;
@property (nullable, nonatomic, retain) NSString *description_text;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSNumber *id_town;
@property (nullable, nonatomic, retain) NSNumber *id_underground;
@property (nullable, nonatomic, retain) NSNumber *id_user;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSNumber *rooms;
@property (nullable, nonatomic, retain) NSString *time_to_underground;
@property (nullable, nonatomic, retain) NSDate *update_date;

@end

NS_ASSUME_NONNULL_END
