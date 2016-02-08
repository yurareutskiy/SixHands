//
//  User.h
//  SixHands
//
//  Created by Anton Scherbakov on 08/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (readonly, strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *photoURL;
@property (strong, nonatomic) NSNumber *id;

+ (instancetype)initUserWithFirstName:(NSString*)firstName LastName:(NSString*)lastName userID:(NSString*)id Email:(NSString*)email Phone:(NSString*)phone PhotoURL:(NSString*)photoURL;

@end
