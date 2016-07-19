//
//  Option.h
//  SixHands
//
//  Created by Андрей on 19.07.16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Realm/Realm.h>
#import "Params.h"
@class Params;

@interface Option : RLMObject

@property NSString *ruName;
@property NSString *enName;
@property Params *param;
@property NSString *ID;

@end

RLM_ARRAY_TYPE(Option)


