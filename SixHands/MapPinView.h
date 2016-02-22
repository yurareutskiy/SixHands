//
//  MapPinView.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/22/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubwayView.h"

@interface MapPinView : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *square;
@property (weak, nonatomic) IBOutlet UILabel *storey;
@property (weak, nonatomic) IBOutlet UILabel *rooms;
@property (weak, nonatomic) IBOutlet SubwayView *subwayName;
@property (weak, nonatomic) IBOutlet UILabel *timeToSubway;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *avatars;
@property (weak, nonatomic) IBOutlet UILabel *othersPeople;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
