//
//  MessViewController.h
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelViewController.h"

@interface MessViewController : ModelViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
