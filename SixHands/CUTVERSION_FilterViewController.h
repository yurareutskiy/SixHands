//
//  CUTVERSION_FilterViewController.h
//  SixHands
//
//  Created by Андрей on 25.07.16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUTVERSION_SWRevealViewController.h"
#import "TTRangeSlider.h"
#import "FilterViewController.h"

@interface CUTVERSION_FilterViewController : FilterViewController<CUTVERSION_SWRevealViewControllerDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *view1;
@property (strong, nonatomic) IBOutlet UIButton *view2;
@property (strong, nonatomic) IBOutlet UIButton *view3;
@property (strong, nonatomic) IBOutlet UIButton *view4;


@property (weak, nonatomic) IBOutlet TTRangeSlider *squareSlider;
@property (weak, nonatomic) IBOutlet TTRangeSlider *priceSlider;

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
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;



@end
