//
//  LoginViewController.h
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelViewController.h"
#import "VKSdk.h"

@interface LoginViewController : UIViewController <VKSdkDelegate>
- (IBAction)skipButtonAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *facebookButton;
@property (strong, nonatomic) IBOutlet UIButton *vkButton;
@property (weak, nonatomic) IBOutlet UIView *backView;
- (IBAction)facebookButtonAction:(UIButton *)sender;
- (IBAction)vkButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;


@end
