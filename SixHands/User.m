//
//  User.m
//  SixHands
//
//  Created by Anton Scherbakov on 08/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)initUserWithFirstName:(NSString*)firstName LastName:(NSString*)lastName userID:(NSString*)id Email:(NSString*)email Phone:(NSString*)phone PhotoURL:(NSString*)photoURL {
    
    User *user = [[User alloc] init];
    
    user.firstName = firstName;
    user.lastName = lastName;
    user.id = [[NSNumber alloc] initWithInt:((NSString*)id).intValue];
    user.email = email;
    user.phone = phone;
    user.photoURL = photoURL;
    
    user.name = [@[firstName, lastName] componentsJoinedByString:@" "];
    
    return user;
}

@end
