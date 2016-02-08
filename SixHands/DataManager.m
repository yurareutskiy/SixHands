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
    
    // USER'S TOKEN
    [ud setObject:result[@"token"] forKey:@"token"];
    
    // USER'S INFO
    Users *user = [Users initUserWithFirstName:result[@"user"][@"first_name"] LastName:result[@"user"][@"last_name"] userID:result[@"user"][@"id"] Email:result[@"user"][@"email"] Phone:result[@"user"][@"phone"] PhotoURL:result[@"user"][@"user_photo_url"] Token:result[@"user"][@"token"] socType:result[@"user"][@"socType"] socID:result[@"user"][@"socId"]];
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [ud setObject:userData forKey:@"user"];
    
    
    // USER'S FLATS
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    if (result[@"flats"] != nil) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Flats" inManagedObjectContext:context];
        for (int i = 0; i < [((NSArray*)result[@"flats"]) count]; i++) {
            NSDictionary *tempDict = result[@"flats"][i];
            NSManagedObject *order = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            
            [order setValue:tempDict[@"address"] forKey:@"address"];
            [order setValue:tempDict[@"create_date"] forKey:@"create_date"];
            [order setValue:tempDict[@"description_text"] forKey:@"description_text"];
            [order setValue:tempDict[@"id"] forKey:@"id"];
            [order setValue:tempDict[@"id_town"] forKey:@"id_town"];
            [order setValue:tempDict[@"id_underground"] forKey:@"id_underground"];
            [order setValue:tempDict[@"id_user"] forKey:@"id_user"];
            [order setValue:tempDict[@"latitude"] forKey:@"latitude"];
            [order setValue:tempDict[@"longitude"] forKey:@"longitude"];
            [order setValue:tempDict[@"price"] forKey:@"price"];
            [order setValue:tempDict[@"rooms"] forKey:@"rooms"];
            [order setValue:tempDict[@"time_to_underground"] forKey:@"time_to_underground"];
            [order setValue:tempDict[@"update_date"] forKey:@"update_date"];
            
            NSError *error = nil;
            [context save:&error];
            if (error) {
                NSLog(@"%@", [error debugDescription]);
            }

        }
    }
    [ud setObject:@"true" forKey:@"isLogin"];
}

- (void)loadDataWithStart:(NSArray*)data From:(NSString*)object {
    
    
    
}

- (NSArray*)getDataFromEntity:(NSString*)entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    return [self getDataFromEntity:entityName AndRequest:fetchRequest];
}

- (NSArray*)getDataFromEntity:(NSString *)entityName AndRequest:(NSFetchRequest*)fetchRequest {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

@end
