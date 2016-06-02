//
//  SettingsViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/11/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ProfilePhotoChangedDelegate <NSObject>

-(void)changingPhoto:(UIImage*)image;
-(void)closeSettings:(UIViewController*)close;

@end

@interface SettingsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak,nonatomic) id <ProfilePhotoChangedDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UIButton *ChangePhoto;

@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;

- (void)addExitButton;
@end
