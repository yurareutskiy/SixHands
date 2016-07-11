//
//  UndergroundList.h
//  SixHands
//
//  Created by _ on 7/11/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Realm/Realm.h>

@interface UndergroundList : RLMObject

@property NSString* ID;
@property NSString* colorID;
@property NSString* colorName;
@property NSString* name;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<UndergroundList>
RLM_ARRAY_TYPE(UndergroundList)

