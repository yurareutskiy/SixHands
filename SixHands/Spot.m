//
//  Spot.m
//  Google Maps iOS Example
//
//  Created by Colin Edwards on 2/1/14.
//
//

#import "Spot.h"

@implementation Spot

- (CLLocationCoordinate2D)position {
    return self.location;
}


+(instancetype)initWithLoction:(CLLocationCoordinate2D)location {
    Spot *spot = [[Spot alloc] init];
    spot.location = location;
    return spot;
}
@end
