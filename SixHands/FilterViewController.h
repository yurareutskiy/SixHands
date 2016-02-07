//
//  MenuViewController.h
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "TTRangeSlider.h"

@interface FilterViewController : UIViewController<SWRevealViewControllerDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *view1;
@property (strong, nonatomic) IBOutlet UIButton *view2;
@property (strong, nonatomic) IBOutlet UIButton *view3;
@property (strong, nonatomic) IBOutlet UIButton *view4;

- (IBAction)view1:(UIButton *)sender;
- (IBAction)view2:(UIButton *)sender;
- (IBAction)view3:(UIButton *)sender;
- (IBAction)view4:(UIButton *)sender;


@end
