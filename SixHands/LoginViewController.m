//
//  LoginViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "LoginViewController.h"
#import "ServerRequest.h"
#import "Server.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FavouriteFlats.h"
#import "UndergroundList.h"
#import "Flat.h"
#import "Params.h"

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
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@NO forKey:@"isVK"];
    [ud setObject:@NO forKey:@"isFB"];
    CGRect rect = self.view.frame;
    self.backView.frame = rect;

}

- (void)startWorking {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *parameters = [[NSDictionary alloc] init];
    NSString *url =  url = @"flats/favourites";
    Server *server = [Server new];
    RLMRealm *realm = [RLMRealm defaultRealm];
    {parameters = @{@"target": @"favourites",@"offset":@"0",@"amount":@"100",@"id_user":@"10"};}
    [realm beginWriteTransaction];
    RLMResults<FavouriteFlats*> *flats = [FavouriteFlats allObjects];
    [realm deleteObjects:flats];
    [realm commitWriteTransaction];

    ServerRequest *requestToGet = [ServerRequest initRequest:ServerRequestTypeGET With:parameters To:url];
    [server sentToServer:requestToGet OnSuccess:^(NSDictionary *result) {

        NSDictionary *key;
        for (key in result) {
                    NSLog(@"result = %@",result);
            FavouriteFlats *favoutiteFlat = [FavouriteFlats new];
            favoutiteFlat.ID = key[@"id"];
      

            [realm beginWriteTransaction];
            [realm addObject:favoutiteFlat];
            [realm commitWriteTransaction];
        }
        NSLog(@"NICE FAV FETCH");
            }  OrFailure:^(NSError *error) {
         NSLog(@"BAD FAV FETCH");
    }];
    parameters = @{@"id_city": @"1"};

    ServerRequest *requestToGetUndergroundList = [ServerRequest initRequest:ServerRequestTypeGET With:parameters To:@"underground"];
    [server sentToServer:requestToGetUndergroundList OnSuccess:^(NSDictionary *result) {
        
        [realm beginWriteTransaction];
        RLMResults<UndergroundList*> *flats = [UndergroundList allObjects];
        [realm deleteObjects:flats];
        [realm commitWriteTransaction];

        NSDictionary *key;
        for (key in result) {
            NSLog(@"result = %@",key);

            UndergroundList *listItem = [UndergroundList new];
            listItem.ID = [NSString stringWithFormat:@"%@",key];
            listItem.name = result[key][@"name"];
            listItem.colorName = result[key][@"color"];

            
            [realm beginWriteTransaction];
            [realm addObject:listItem];
            [realm commitWriteTransaction];
        }
        NSLog(@"NICE UNDERGROUND FETCH");
    }  OrFailure:^(NSError *error) {
        NSLog(@"BAD UNDERGROUND FETCH");
    }];
    
    ServerRequest *requestToPost = [ServerRequest initRequest:ServerRequestTypeGET With:nil
                                                           To:@"parameters"];
    [server sentToServer:requestToPost OnSuccess:^(NSDictionary *result) {
        
        NSString *key = [[NSString alloc] init];
        
        for (key in result)
        {
            
            Params *oneParam = [[Params alloc] init];
            oneParam.ID = key;
            NSDictionary *tmp = [result objectForKey:key];
            if([tmp objectForKey:@"translations"] != nil)
            {
                oneParam.RULocale = tmp[@"translations"][@"1"];
                oneParam.name = tmp[@"translations"][@"2"];
            }
            [realm beginWriteTransaction];
            [realm addOrUpdateObject:oneParam];
            [realm commitWriteTransaction];
        }
        [self performSegueWithIdentifier:@"test" sender:self];

    }  OrFailure:^(NSError *error) {
        
    }];

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
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile",@"email",@"user_about_me",@"user_location"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"picture,name,location"}]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
                          NSLog(@"result %@",result);
                          NSMutableArray *mutableWords = [[result[@"name"]  componentsSeparatedByString: @" "] mutableCopy];
                          NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                          [ud setObject: mutableWords[0] forKey:@"first_name"];
                          [ud setObject: result[@"location"][@"name"] forKey:@"location"];
                          [ud setObject: mutableWords[2] forKey:@"last_name"];
                          [ud setObject: @YES forKey:@"isLogined"];
                          [ud setObject: @YES forKey:@"isFB"];
                          [ud setObject: result[@"picture"][@"data"][@"url"] forKey:@"photo_url"];
                          
                          
                          NSDictionary *parameters = [[NSDictionary alloc] init];
                          parameters = @{@"type": @"fb", @"email": [[VKSdk accessToken] email],@"sn_id": [[VKSdk accessToken] userId]};
                          ServerRequest *requestToPost = [ServerRequest initRequest:ServerRequestTypePOST With:parameters To:@"user"];
                          Server *server = [Server new];
                          [server sentToServer:requestToPost OnSuccess:^(NSDictionary *result) {
                              [ud setObject:[[NSString alloc] initWithFormat:@"%@",result[@"id"]] forKey:@"user_id"];
                              [self startWorking];
                          }  OrFailure:^(NSError *error) {
                              
                              NSDictionary *parametersToSign = [[NSDictionary alloc] init];
                              parametersToSign = @{@"type": @"vk", @"email": [[VKSdk accessToken] email],@"sn_id": [[VKSdk accessToken] userId]};
                              
                              ServerRequest *requestToSign = [ServerRequest initRequest:ServerRequestTypeGET With:parametersToSign To:@"user"];
                              Server *server = [Server new];
                              [server sentToServer:requestToSign OnSuccess:^(NSDictionary *result) {
                                  [ud setObject:[[NSString alloc] initWithFormat:@"%@",[[[VKSdk accessToken] localUser] id]] forKey:@"user_id"];
                                  [self startWorking];
                              }  OrFailure:^(NSError *error) {
                                  NSLog(@"Bad sign");
                              }];
                              
                          }];
                      }
                  }];
             }
             [self startWorking];
         }
     }];
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
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (result.token) {
        NSDictionary *parameters = [[NSDictionary alloc] init];
        parameters = @{@"type": @"vk", @"email": [[VKSdk accessToken] email],@"sn_id": [[VKSdk accessToken] userId]};
        ServerRequest *requestToPost = [ServerRequest initRequest:ServerRequestTypePOST With:parameters To:@"user"];
        Server *server = [Server new];
        [server sentToServer:requestToPost OnSuccess:^(NSDictionary *result) {
            [ud setObject:[[NSString alloc] initWithFormat:@"%@",result[@"id"]] forKey:@"user_id"];
            [self startWorking];
        }  OrFailure:^(NSError *error) {
        
            NSDictionary *parametersToSign = [[NSDictionary alloc] init];
            parametersToSign = @{@"type": @"vk", @"email": [[VKSdk accessToken] email],@"sn_id": [[VKSdk accessToken] userId]};
            
            ServerRequest *requestToSign = [ServerRequest initRequest:ServerRequestTypeGET With:parametersToSign To:@"user"];
            Server *server = [Server new];
            [server sentToServer:requestToSign OnSuccess:^(NSDictionary *result) {
                    [ud setObject:[[NSString alloc] initWithFormat:@"%@",[[[VKSdk accessToken] localUser] id]] forKey:@"user_id"];
                     [self startWorking];
            }  OrFailure:^(NSError *error) {
                NSLog(@"Bad sign");
            }];
           
        }];
               VKRequest * audioReq = [[VKApi users] get:@{@"fields":@"country,city"}];
        [audioReq executeWithResultBlock:^(VKResponse * response) {
            [ud setObject:response.json[0][@"country"][@"title"] forKey:@"countryName"];
            [ud setObject:response.json[0][@"city"][@"title"] forKey:@"cityName"];
            
        } errorBlock:^(NSError *error) {
            
            NSLog(@"VK error: %@", error);
            
        }];

        [ud setObject:   [[[VKSdk accessToken] localUser] photo_200] forKey:@"photo_url"];
        [ud setObject:@YES forKey:@"isVK"];
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
