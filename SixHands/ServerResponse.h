//
//  ServerResponse.h
//  Cupsters
//
//  Created by Reutskiy Jury on 1/19/16.
//  Copyright © 2016 Styleru. All rights reserved.
//


//TODO: мб стоит убрать все типы и оставить success and error

typedef enum {
    ServerResponseTypeSuccess,
    ServerResponseTypeError,
    ServerResponseTypeLogin,
    ServerResponseTypeRegistry
} ServerResponseType;

#import <Foundation/Foundation.h>
#import "ServerError.h"

@interface ServerResponse : NSURLResponse

@property (assign, nonatomic) ServerResponseType type;
@property (strong, nonatomic) NSDictionary *body;
@property (strong, nonatomic) ServerError *error;

+ (instancetype)parseResponse:(NSDictionary*)response;

@end
