//
//  Params.h
//  SixHands
//
//  Created by rGradeStd on 6/2/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Realm/Realm.h>

@interface Params : RLMObject

@property NSString* name;
@property NSString* ID;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Params>
RLM_ARRAY_TYPE(Params)
