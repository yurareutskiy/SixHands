//
//  ListTableViewCell.h
//  SixHands
//
//  Created by Anton Scherbakov on 07/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIButton *hands;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addressWidth;
@property (strong, nonatomic) IBOutlet UIImageView *avatar1;
@property (strong, nonatomic) IBOutlet UIImageView *avatar2;
@property (strong, nonatomic) IBOutlet UIImageView *avatar3;

@end
