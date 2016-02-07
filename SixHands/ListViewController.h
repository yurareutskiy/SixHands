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

@interface ListViewController : ModelViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
