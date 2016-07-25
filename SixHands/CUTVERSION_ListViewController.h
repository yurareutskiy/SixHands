//
//  CUTVERSION_ListViewController.h
//  SixHands
//
//  Created by Андрей on 25.07.16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelViewController.h"
#import "ListTableViewCell.h"
#import "FilterViewController.h"
#import "SWRevealViewController.h"
#import "ListViewController.h"

@interface CUTVERSION_ListViewController : ListViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *buttonNew;
@property (strong, nonatomic) IBOutlet UIButton *popularButton;
@property (strong, nonatomic) IBOutlet UIButton *favButton;
@property (strong, nonatomic) IBOutlet UIView *viewNew;
@property (strong, nonatomic) IBOutlet UIView *viewPopular;
@property (strong, nonatomic) IBOutlet UIView *viewFav;

-(void)triger;
-(void)trigerThree:(NSDictionary*) dict;
- (UIColor*) checkColor:(NSString*) ID;
- (IBAction)buttonNew:(UIButton *)sender;
- (IBAction)popularButton:(UIButton *)sender;
- (IBAction)favButton:(UIButton *)sender;


@end
