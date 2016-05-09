//
//  PhoneViewController.h
//  SixHands
//
//  Created by Anton Scherbakov on 07/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSPhoneLibrary.h"

@interface PhoneViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet SHSPhoneTextField *phoneField;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UILabel *plsInput;


@property (strong, nonatomic) IBOutlet UILabel *plsCode;
@property (strong, nonatomic) IBOutlet UITextField *notCode;
@property (strong, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backButtonAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *codeLabels;

@end