//
//  SettingsViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/11/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.applyButton.layer.cornerRadius = 8;
//    self.applyButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.applyButton.layer.borderWidth = 1;
//    NSLog(@"%f", self.exitButton.frame.origin.y);
//
//    [self addExitButton];
//    NSLog(@"%f", self.exitButton.frame.origin.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addExitButton {
    CGRect rect = self.exitButton.frame;
    float screenHeight = self.view.frame.size.height;
    float buttonHeight = rect.size.height;
    rect.origin.y = screenHeight - buttonHeight - 10;
    self.exitButton.frame = rect;
    
    self.bottomConst.constant = 50.0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
