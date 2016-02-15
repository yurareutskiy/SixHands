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

@interface FilterViewController : UIViewController<SWRevealViewControllerDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *view1;
@property (strong, nonatomic) IBOutlet UIButton *view2;
@property (strong, nonatomic) IBOutlet UIButton *view3;
@property (strong, nonatomic) IBOutlet UIButton *view4;

@property (strong, nonatomic) IBOutlet UIButton *aloneRoom;
@property (strong, nonatomic) IBOutlet UIButton *room1;
@property (strong, nonatomic) IBOutlet UIButton *room2;
@property (strong, nonatomic) IBOutlet UIButton *room3;
@property (strong, nonatomic) IBOutlet UIButton *room4;
@property (strong, nonatomic) IBOutlet UIButton *room;

- (IBAction)view1:(UIButton *)sender;
- (IBAction)view2:(UIButton *)sender;
- (IBAction)view3:(UIButton *)sender;
- (IBAction)view4:(UIButton *)sender;

- (IBAction)aloneRoom:(UIButton *)sender;
- (IBAction)room1:(UIButton *)sender;
- (IBAction)room2:(UIButton *)sender;
- (IBAction)room3:(UIButton *)sender;
- (IBAction)room4:(UIButton *)sender;
- (IBAction)room:(UIButton *)sender;

- (IBAction)type:(UIButton *)sender;
- (IBAction)params:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
