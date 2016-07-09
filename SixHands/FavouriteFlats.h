//
//  FavouriteFlats.h
//  SixHands
//
//  Created by _ on 7/9/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Realm/Realm.h>

@interface FavouriteFlats : RLMObject
@property NSString *ID;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<FavouriteFlats>
RLM_ARRAY_TYPE(FavouriteFlats)
