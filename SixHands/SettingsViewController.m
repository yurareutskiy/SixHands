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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
