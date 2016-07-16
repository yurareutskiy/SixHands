//
//  Flat.h
//  SixHands
//
//  Created by rGradeStd on 6/2/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Realm/Realm.h>
#import "FlatPhoto.h"

@interface Flat : RLMObject
+ (NSString *)primaryKey;
@property NSString* ID;
@property NSString* address;
@property NSString* latitude;
@property NSString* longitude;
@property NSString* price;
@property NSString* square;
@property NSString* parameters;
@property RLMArray<FlatPhoto> *photos;
@property NSString* undegroundName;
@property NSString* undergroundColor;
@property NSString* createDate;
@property NSString* updateDate;
-(void)print;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Flat>
RLM_ARRAY_TYPE(Flat)
