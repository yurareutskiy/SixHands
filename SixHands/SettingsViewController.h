//
//  SettingsViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/11/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;

- (void)addExitButton;
@end
