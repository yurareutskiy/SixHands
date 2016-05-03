//
//  ServerError.m
//  Cupsters
//
//  Created by Reutskiy Jury on 1/19/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ServerError.h"

@implementation ServerError

+ (instancetype)initWithResponse:(NSDictionary*)response {
    ServerError *error = [[ServerError alloc] init];
    if( response[@"message"]  != NULL && response[@"code"]!= NULL)
    {
        error.message = response[@"message"];
        error.serverCode = response[@"code"];
    }
    return error;
}

-(NSString *)debugDescription {
    NSString *description = [NSString stringWithFormat:@"Server error - %@ \nCode - %@", self.message, self.serverCode];
    return description;
}

@end
