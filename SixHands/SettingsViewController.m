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
    self.applyButton.layer.cornerRadius = 8;
    self.applyButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.applyButton.layer.borderWidth = 1;
    NSLog(@"%f", self.exitButton.frame.origin.y);

    [self addExitButton];
    NSLog(@"%f", self.exitButton.frame.origin.y);
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addExitButton {
    CGRect rect = self.exitButton.frame;
    float screenHeight = self.view.frame.size.height;
    
//    float screenWidth = self.view.frame.size.width;
//    CGRect newRect = CGRectMake(screenWidth - 17.5, screenHeight - 45, 80, 35);
//    CGRect newRect = CGRectMake(0, 0, 80, 35);
//    UIButton *button = [[UIButton alloc] initWithFrame:newRect];
//    button.titleLabel.text = @"Выход";
//    button.titleLabel.textColor = [UIColor colorWithRed:69.f/255.f green:210.f/255.f blue:157.f/255.f alpha:1.f];
//    [self.view addSubview:button];
    
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
