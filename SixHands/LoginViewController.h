//
//  LoginViewController.h
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)skipButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *facebookButton;
@property (strong, nonatomic) IBOutlet UIButton *vkButton;
- (IBAction)facebookButtonAction:(UIButton *)sender;
- (IBAction)vkButtonAction:(UIButton *)sender;


@end
