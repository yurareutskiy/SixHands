//
//  DataManager.h
//  SixHands
//
//  Created by Anton Scherbakov on 08/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Users.h"
#import "AppDelegate.h"

@interface DataManager : NSFetchedResultsController

- (void) saveDataWithLogin:(NSDictionary*)result;
- (void)loadDataWithStart:(NSArray*)data From:(NSString*)object;
- (NSArray*)getDataFromEntity:(NSString*)entityName;
- (NSArray*)getDataFromEntity:(NSString *)entityName AndRequest:(NSFetchRequest*)fetchRequest;

+ (instancetype)sharedManager;

@end
