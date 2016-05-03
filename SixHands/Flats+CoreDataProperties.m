//
//  Flats+CoreDataProperties.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/23/16.
//  Copyright © 2016 Styleru. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Flats+CoreDataProperties.h"

@implementation Flats (CoreDataProperties)

@dynamic address;
@dynamic create_date;
@dynamic description_text;
@dynamic id;
@dynamic id_town;
@dynamic id_underground;
@dynamic id_user;
@dynamic latitude;
@dynamic longitude;
@dynamic price;
@dynamic rooms;
@dynamic time_to_underground;
@dynamic update_date;

+ (id)insertNewObjectInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Flats" inManagedObjectContext:context];
}

@end
