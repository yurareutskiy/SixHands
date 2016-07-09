//
//  ProfileViewController.h
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelViewController.h"
#import "SettingsViewController.h"
#import "VKSdk.h"

@interface ProfileViewController : ModelViewController <UITableViewDataSource, UITableViewDelegate, ProfilePhotoChangedDelegate,VKSdkDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userNameTitle;
@property (weak, nonatomic) IBOutlet UILabel *userLocationTitle;

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UIButton *vkButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *rentButton;
- (void) FBLogin;
- (IBAction)vkButtonAction:(UIButton *)sender;
- (IBAction)facebookButtonAction:(UIButton *)sender;
- (IBAction)rentButtonAction:(UIButton *)sender;



@end
