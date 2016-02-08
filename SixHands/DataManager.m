//
//  DataManager.m
//  SixHands
//
//  Created by Anton Scherbakov on 08/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static DataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark Another methods

- (void) saveDataWithLogin:(NSDictionary*)result{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:result[@"token"] forKey:@"token"];
    
//    User *user = [User initUserWithFirstName:result[@"user"][@"first_name"] LastName:result[@"user"][@"last_name"] userID:result[@"user"][@"id"] Email:result[@"user"][@"email"] Phone:result[@"user"][@"phone"] PhotoURL:result[@"user"][@"user_photo_url"]];
//    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
//    [ud setObject:userData forKey:@"user"];
}

@end
