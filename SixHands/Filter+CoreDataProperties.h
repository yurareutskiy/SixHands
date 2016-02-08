//
//  Filter+CoreDataProperties.h
//  SixHands
//
//  Created by Anton Scherbakov on 08/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Filter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Filter (CoreDataProperties)

@property (nullable, nonatomic, retain) id params;
@property (nullable, nonatomic, retain) Flats *filter;

@end

NS_ASSUME_NONNULL_END
