//
//  Users.m
//  SixHands
//
//  Created by Anton Scherbakov on 08/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "Users.h"

@implementation Users

// Insert code here to add functionality to your managed object subclass

+ (instancetype)initUserWithFirstName:(NSString*)firstName LastName:(NSString*)lastName userID:(NSString*)id Email:(NSString*)email Phone:(NSString*)phone PhotoURL:(NSString*)photoURL Token:(NSString*)token socType:(NSString*)socType socID:(NSString*)socID {
    
    Users *user = [[Users alloc] init];
    
    user.first_name = firstName;
    user.last_name = lastName;
    user.id = [[NSNumber alloc] initWithInt:((NSString*)id).intValue];
    user.email = email;
    user.phone = phone;
    user.user_photo_url = photoURL;
    user.token = token;
    if ([socType isEqualToString:@"vk"]) {
        user.vk_id = [[NSNumber alloc] initWithInt:((NSString*)socID).intValue];
    } else if ([socType isEqualToString:@"fb"]) {
        user.fb_id = [[NSNumber alloc] initWithInt:((NSString*)socID).intValue];
    }
    
    return user;
}

@end
