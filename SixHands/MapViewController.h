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
@import GoogleMaps;

@interface MapViewController : UIViewController<CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, GMSMapViewDelegate>
- (IBAction)plusButton:(UIButton *)sender;
- (IBAction)minusButton:(UIButton *)sender;
- (IBAction)upDownButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *upDownButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *upDownTop;

@end
