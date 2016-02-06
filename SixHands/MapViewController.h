//
//  MapViewController.h
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FilterViewController.h"
#import "SWRevealViewController.h"
#import "GClusterManager.h"
#import "NonHierarchicalDistanceBasedAlgorithm.h"
#import "GDefaultClusterRenderer.h"
#import "Spot.h"
@import GoogleMaps;

@interface MapViewController : UIViewController<CLLocationManagerDelegate, GMSMapViewDelegate>
- (IBAction)plusButton:(UIButton *)sender;
- (IBAction)minusButton:(UIButton *)sender;

@end
