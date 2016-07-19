//
//  ListViewController.h
//  SixHands
//
//  Created by Anton Scherbakov on 06/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelViewController.h"
#import "ListTableViewCell.h"
#import "FilterViewController.h"
#import "SWRevealViewController.h"

@interface ListViewController : ModelViewController<UITableViewDelegate, UITableViewDataSource>
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
