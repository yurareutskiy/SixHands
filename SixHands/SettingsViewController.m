//
//  SettingsViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/11/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "SettingsViewController.h"
#import "VKSdk.h"

@interface SettingsViewController ()
@property (nonatomic,strong) XHPhotographyHelper *photographyHelper;
@end

@implementation SettingsViewController{
    ProfileViewController *profileVC;
}

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
- (IBAction)logoutClick:(id)sender {
    [VKSdk forceLogout];
    UIViewController *toLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginPoint"];
    [self presentViewController:toLogin animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [[NSUserDefaults standardUserDefaults] setObject:UIImageJPEGRepresentation(image, 1.0) forKey:@"avatar"];
    [self.delegate changingPhoto:image];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
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

