//
//  Flat.m
//  SixHands
//
//  Created by rGradeStd on 6/2/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "Flat.h"

@implementation Flat

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}
-(void) print
{
    NSLog(@"FLAT = %@,%@,%@,%@,%@",self.address,self.longitude,self.latitude,self.price,self.square);
}

@end
