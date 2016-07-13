//
//  FlatPhoto.h
//  SixHands
//
//  Created by _ on 7/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Realm/Realm.h>

@interface FlatPhoto : RLMObject
@property NSString* url;
@property NSString* selfdescription;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<FlatPhoto>
RLM_ARRAY_TYPE(FlatPhoto)
