//
//  ParameterTableViewCell.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/18/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParameterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@end
