//
//  ServerResponse.m
//  Cupsters
//
//  Created by Reutskiy Jury on 1/19/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ServerResponse.h"

@implementation ServerResponse

+ (instancetype)parseResponse:(NSDictionary*)response {

    ServerResponse *object = [[ServerResponse alloc] init];
//    NSLog(@"RESPONSE %@",response);
    object.type = [(NSString*)response[@"response"] isEqualToString:@"Success"] ? ServerResponseTypeSuccess : ServerResponseTypeError;
    if (object.type == ServerResponseTypeSuccess) {
        object.body = response[@"body"];
    } else if (object.type == ServerResponseTypeError) {
        object.error = [ServerError initWithResponse:response[@"error"]];
    }
    
    return object;
}

@end
