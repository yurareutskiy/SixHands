//
//  SettingsViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/11/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "SettingsViewController.h"
#import "ProfileViewController.h"
#import "MessageDisplayKit/XHPhotographyHelper.h"
@interface SettingsViewController ()
@property (nonatomic,strong) XHPhotographyHelper *photographyHelper;
@end

@implementation SettingsViewController{
    ProfileViewController *ProfileVC;
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
#pragma mark -
#pragma mark IBActions
- (IBAction)ChangePhoto:(UIButton *)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
// [self.photographyHelper showOnPickerViewControllerSourceType:UIImagePickerControllerSourceTypeCamera onViewController:self compled:PickerMediaBlock];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

//- (void) imagePickerController:(UIImagePickerController *)picker
//         didFinishPickingImage:(UIImage *)image
//                   editingInfo:(NSDictionary *)editingInfo
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    ProfileVC.userPhoto.image = image;
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
