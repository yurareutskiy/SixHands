//
//  FlatViewController.h
//  SixHands
//
//  Created by Anton Scherbakov on 03/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelViewController.h"

@interface FlatViewController : ModelViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *cofirmButton;
@property (weak, nonatomic) IBOutlet UIView *capView;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSString *address;




@end
