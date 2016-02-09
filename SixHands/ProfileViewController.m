//
//  ProfileViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ProfileViewController.h"

@interface UIImage (ImageBlur)
- (UIImage *)imageWithGaussianBlur;
@end

@implementation UIImage (ImageBlur)
    NSInteger counter = 0;

- (UIImage *)imageWithGaussianBlur {
    float weight[5] = {0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 0.0162162162};
    // Blur horizontally
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[0]];
    for (int x = 1; x < 5; ++x) {
        [self drawInRect:CGRectMake(x, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[x]];
        [self drawInRect:CGRectMake(-x, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[x]];
    }
    UIImage *horizBlurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Blur vertically
    UIGraphicsBeginImageContext(self.size);
    [horizBlurredImage drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[0]];
    for (int y = 1; y < 5; ++y) {
        [horizBlurredImage drawInRect:CGRectMake(0, y, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[y]];
        [horizBlurredImage drawInRect:CGRectMake(0, -y, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[y]];
    }
    UIImage *blurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //
    if (counter <= 5) {
        return blurredImage;
    }
    counter++;
    return [blurredImage imageWithGaussianBlur];
}

@end

@interface ProfileViewController ()

@end

@implementation ProfileViewController

#pragma mark - init custom

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Профиль";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0]];
    self.backPhoto.image = [[UIImage imageNamed:@"avatar2"] imageWithGaussianBlur];
    self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.width / 2;
    self.userPhoto.layer.borderWidth = 2.f;
    self.userPhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userPhoto.layer.masksToBounds = YES;
    
    [self customNavBar];
    
    // Do any additional setup after loading the view.
}

- (void)customNavBar {
    UIBarButtonItem *settingsItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gear39-2"]
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(settingsMenu:)];
    
    self.navigationItem.rightBarButtonItem = settingsItem;
}


#pragma mark - Actions

- (void)settingsMenu:(id)sender {
    
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

@end



