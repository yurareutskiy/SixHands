//
//  LoginViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "LoginViewController.h"
#import "VKSdk.h"
#import "ServerRequest.h"
#import "Server.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSArray *SCOPE = nil;

@interface LoginViewController () <UIAlertViewDelegate, VKSdkUIDelegate,VKSdkDelegate>

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
    SCOPE = @[VK_PER_FRIENDS, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL,VK_PER_STATS,VK_PER_STATUS];
    [super viewDidLoad];
    [[VKSdk initializeWithAppId:@"5446345"] registerDelegate:self ];
    [[VKSdk instance] setUiDelegate:self];
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            [self startWorking];
            NSLog(@"%@",[[[VKSdk accessToken] localUser] photo_200]);
        } else if (error) {
//            [[[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }];
//
    
    CGRect rect = self.view.frame;
    self.backView.frame = rect;

}

- (void)startWorking {
    [self performSegueWithIdentifier:@"test" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)skipButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"nextButton" sender:self];
}
- (IBAction)facebookButtonAction:(UIButton *)sender {

}

- (IBAction)vkButtonAction:(UIButton *)sender {
    
    [VKSdk authorize:SCOPE];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self.navigationController.topViewController];
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    [self authorize:nil];
}

-(void) vkSdkDidReceiveNewToken:(VKAccessToken*) newToken{
    NSLog(@"%@",newToken);
}
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
                NSDictionary *parameters = [[NSDictionary alloc] init];
        parameters = @{@"type": @"vk", @"email": [[VKSdk accessToken] email],@"sn_id": [[VKSdk accessToken] userId]};
        ServerRequest *requestToPost = [ServerRequest initRequest:ServerRequestTypePOST With:parameters To:@"login"];
        Server *server = [Server new];
        [server sentToServer:requestToPost OnSuccess:^(NSDictionary *result) {
            [self startWorking];
        }  OrFailure:^(NSError *error) {
            NSDictionary *parametersToSign = [[NSDictionary alloc] init];
            parametersToSign = @{@"type": @"vk", @"email": [[VKSdk accessToken] email],@"sn_id": [[VKSdk accessToken] userId],@"first_name": [[[VKSdk accessToken] localUser] first_name],@"last_name": [[[VKSdk accessToken] localUser] last_name]};
            
            ServerRequest *requestToSign = [ServerRequest initRequest:ServerRequestTypePOST With:parametersToSign To:@"signin"];
            Server *server = [Server new];
            [server sentToServer:requestToSign OnSuccess:^(NSDictionary *result) {
                NSLog(@"NICE SIGN");
            }  OrFailure:^(NSError *error) {
                NSLog(@"Bad sign");
            }];
           
        }];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        VKRequest * audioReq = [[VKApi users] get:@{@"fields":@"country,city"}];
        [audioReq executeWithResultBlock:^(VKResponse * response) {
            [ud setObject:response.json[0][@"country"][@"title"] forKey:@"countryName"];
            [ud setObject:response.json[0][@"city"][@"title"] forKey:@"cityName"];
            
        } errorBlock:^(NSError *error) {
            
            NSLog(@"VK error: %@", error);
            
        }];
    
        [ud setObject:@YES forKey:@"isLogined"];
        [ud setObject:[[[VKSdk accessToken] localUser] first_name] forKey:@"first_name"];
        [ud setObject:[[[VKSdk accessToken] localUser] last_name] forKey:@"last_name"];
    } else if (result.error) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Что-то пошло не так,повторите попытку\n;(" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (IBAction)authorize:(id)sender {
    [VKSdk authorize:SCOPE];
}

- (void)vkSdkUserAuthorizationFailed {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Что-то пошло не так,повторите попытку\n;(" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
