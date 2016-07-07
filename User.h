//
//  User.h
//  SixHands
//
//  Created by _ on 7/5/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Realm/Realm.h>

@interface User : RLMObject

@property NSString *ID;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *email;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<User>
RLM_ARRAY_TYPE(User)
