//
//  LoginViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vkButton.layer.cornerRadius = 7.f;
    self.facebookButton.layer.cornerRadius = 7.f;
    self.vkButton.layer.borderWidth = 1.f;
    self.facebookButton.layer.borderWidth = 1.f;
    self.vkButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.facebookButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.facebookButton.imageView.image = [self imageWithImage:self.facebookButton.imageView.image scaledToSize:CGSizeMake(60, 60)];
//    
    CGRect rect = self.view.frame;
    self.backView.frame = rect;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)skipButton:(UIButton *)sender {
//    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
//    [self presentViewController:vc animated:true completion:nil];
    [self performSegueWithIdentifier:@"nextButton" sender:self];
}
- (IBAction)facebookButtonAction:(UIButton *)sender {
}

- (IBAction)vkButtonAction:(UIButton *)sender {
}
@end
