//
//  Users+CoreDataProperties.h
//  SixHands
//
//  Created by Anton Scherbakov on 08/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Users.h"

NS_ASSUME_NONNULL_BEGIN

@interface Users (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *first_name;
@property (nullable, nonatomic, retain) NSString *last_name;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *user_photo_url;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSNumber *vk_id;
@property (nullable, nonatomic, retain) NSNumber *fb_id;
@property (nullable, nonatomic, retain) NSString *phone;

@end

NS_ASSUME_NONNULL_END
