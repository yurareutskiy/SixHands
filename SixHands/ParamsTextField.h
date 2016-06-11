//
//  ParamsTextField.h
//  SixHands
//
//  Created by rGradeStd on 6/8/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Params.h"
@interface ParamsTextField : UITextField <UITextFieldDelegate>

@property NSString* ID;
@property Params* param;
@end
