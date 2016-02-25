//
//  Filter+CoreDataProperties.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/23/16.
//  Copyright © 2016 Styleru. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Filter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Filter (CoreDataProperties)

@property (nullable, nonatomic, retain) id params;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
