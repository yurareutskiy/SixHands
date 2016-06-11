//
//  ParameterTableViewCell.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/18/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParamsTextField.h"
#import "Params.h"

@interface ParameterTableViewCell : UITableViewCell

@property NSString* ID;
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property  IBOutlet ParamsTextField *valueTextField;

@end
