//
//  ProfileViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ProfileViewController.h"
#import "ListTableViewCell.h"
#import "SettingsViewController.h"
#import "User.h"
#import "Server.h"
#import "Flat.h"
#import "VKsdk.h"
#import "Params.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UndergroundList.h"

static NSArray *SCOPE = nil;

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

@interface ProfileViewController () < VKSdkUIDelegate,VKSdkDelegate>

@property (strong, nonatomic) SettingsViewController *vc;
@property (strong, nonatomic) UIView *blackoutView;
@property (strong, nonatomic) NSArray *source;
@end

@implementation ProfileViewController

#pragma mark - init custom

- (void)viewDidLoad {

    [super viewDidLoad];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSLog(@"IS VK - %@",[ud objectForKey:@"isVK"]);
    NSLog(@"IS FB - %@",[ud objectForKey:@"isFB"]);
    [self test:1];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.userInteractionEnabled = NO;
    NSString *firstName = [ud objectForKey:@"first_name"];
    NSString *lastName = [ud objectForKey:@"last_name"];
    NSString *countryName = [ud objectForKey:@"countryName"];
    NSString *cityName = [ud objectForKey:@"cityName"];
    self.userNameTitle.text = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
    self.navigationItem.title = @"Профиль";
    self.userLocationTitle.text = [NSString stringWithFormat:@"%@,%@",countryName,cityName];
   SCOPE = @[VK_PER_FRIENDS, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL,VK_PER_STATS,VK_PER_STATUS];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0]];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    if([[ud objectForKey:@"isVK"]  isEqual: @YES] )
    {
        self.vkButton.selected = YES;
        self.vkButton.backgroundColor = [UIColor colorWithRed:69.0/255.0 green:104.0/255.0 blue:142.0/255.0 alpha:1.0];
    }
    else
    {
       self.vkButton.selected = NO;
       self.vkButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"light_gray"]];
    }
    _userLocationTitle.text = [ud objectForKey:@"location"];
    if([[ud objectForKey:@"isFB"]  isEqual: @YES])
    {
        self.facebookButton.selected = YES;
        self.facebookButton.backgroundColor = [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0];
    }
    else{
        
        self.facebookButton.selected = NO;
        self.facebookButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"light_gray"]];
    }
    
    NSString *PhotoURL = [ud objectForKey:@"photo_url"];
    [manager downloadImageWithURL:[NSURL URLWithString: PhotoURL]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             NSLog(@"%ld",(long)receivedSize);
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                [[self userPhoto] setImage:image];
                                SDImageCache *imageCache = [[SDImageCache alloc] initWithNamespace:@"userPhotos"];
                                [imageCache storeImage:image forKey:@"profilePhoto" toDisk:YES];
                                
                            }
                            
                        }];

    SDImageCache *imageCache = [[SDImageCache alloc] initWithNamespace:@"userPhotos"];
     [imageCache queryDiskCacheForKey:@"profilePhoto" done:^(UIImage *image, SDImageCacheType cacheType){
         [[self userPhoto] setImage:image];
    }];
    
    

    self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.width / 2;
    self.userPhoto.layer.borderWidth = 2.f;
    self.userPhoto.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.userPhoto.layer.masksToBounds = YES;
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
    if (imageData != nil) {
        UIImage *avatar = [UIImage imageWithData:imageData];
        [self.userPhoto setImage:avatar];
    }
    [self customNavBar];
    [[VKSdk initializeWithAppId:@"5446345"] registerDelegate:self ];
    [[VKSdk instance] setUiDelegate:self];
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            
            NSLog(@"%@",[[[VKSdk accessToken] localUser] photo_200]);
        } else if (error) {
            //            [[[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }];

    // Do any additional setup after loading the view.
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
//        ServerRequest *requestToPost = [ServerRequest initRequest:ServerRequestTypePOST With:parameters To:@"user"];
//        Server *server = [Server new];
//        [server sentToServer:requestToPost OnSuccess:^(NSDictionary *result) {
//            [self startWorking];
//            [ud setObject:[[NSString alloc] initWithFormat:@"%@",result[@"id"]] forKey:@"user_id"];
//        }  OrFailure:^(NSError *error) {
//            
//            NSDictionary *parametersToSign = [[NSDictionary alloc] init];
//            parametersToSign = @{@"type": @"vk", @"email": [[VKSdk accessToken] email],@"sn_id": [[VKSdk accessToken] userId]};
//            
//            ServerRequest *requestToSign = [ServerRequest initRequest:ServerRequestTypeGET With:parametersToSign To:@"user"];
//            Server *server = [Server new];
//            [server sentToServer:requestToSign OnSuccess:^(NSDictionary *result) {
//                [ud setObject:[[NSString alloc] initWithFormat:@"%@",[[[VKSdk accessToken] localUser] id]] forKey:@"user_id"];
//                [self startWorking];
//            }  OrFailure:^(NSError *error) {
//                NSLog(@"Bad sign");
//            }];
//            
//        }];
//        VKRequest * audioReq = [[VKApi users] get:@{@"fields":@"country,city"}];
//        [audioReq executeWithResultBlock:^(VKResponse * response) {
//            [ud setObject:response.json[0][@"country"][@"title"] forKey:@"countryName"];
//            [ud setObject:response.json[0][@"city"][@"title"] forKey:@"cityName"];
//            
//        } errorBlock:^(NSError *error) {
//            
//            NSLog(@"VK error: %@", error);
//            
//        }];
        
        [ud setObject:   [[[VKSdk accessToken] localUser] photo_200] forKey:@"photo_url"];
        [ud setObject:@YES forKey:@"isVK"];
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

- (void)customNavBar {
    UIBarButtonItem *settingsItem = [[UIBarButtonItem alloc] initWithImage:[self imageWithImage:[UIImage imageNamed:@"tool"] scaledToSize:CGSizeMake(20, 20)]
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(settingsMenu:)];
    
    self.navigationItem.rightBarButtonItem = settingsItem;
}


#pragma mark - Actions

-(void)closeSettings:(UIViewController *)close{
    [self hideSettings:close];
}
-(void)changingPhoto:(UIImage *)image{
    [self.userPhoto setImage:image];
}
- (void)settingsMenu:(id)sender {
    if (!self.vc) {
        self.vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
        self.vc.delegate = self;
    }
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideSettings:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.vc.view addGestureRecognizer:swipe];
    self.vc.view.hidden = NO;
    
    if (!self.blackoutView) {

        
        self.blackoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.blackoutView.backgroundColor = [UIColor blackColor];
        self.blackoutView.alpha = 0;
        [self.tabBarController.view addSubview:self.blackoutView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSettings:)];
        [self.blackoutView addGestureRecognizer:tap];
    }
    
    self.blackoutView.hidden = NO;
    CGRect rectMenu = CGRectMake(self.view.frame.size.width, 0, 280, self.view.frame.size.height);
    self.vc.view.frame = rectMenu;
    [self.tabBarController.view addSubview:self.vc.view];
    self.view.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect newRect = CGRectMake(self.view.frame.size.width - 280, 0, 280, self.view.frame.size.height);
        self.vc.view.frame = newRect;
        self.blackoutView.alpha = 0.5;
    }];



}

- (void) FBLogin
{
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
                      }
                  }];
             }
             //login method
         }
     }];
    
}


- (void)hideSettings:(id)sender {
//    UIView *vc = [self.tabBarController.view.subviews lastObject];
    self.view.userInteractionEnabled = YES;

    [UIView animateWithDuration:0.4 animations:^{
        CGRect newRect = CGRectMake(self.view.frame.size.width, 0, 280, self.view.frame.size.height);
        self.vc.view.frame = newRect;
        self.blackoutView.alpha = 0;
    } completion:^(BOOL finished) {
        self.blackoutView.hidden = YES;
        [self.tabBarController.view removeGestureRecognizer:[self.tabBarController.view.gestureRecognizers firstObject]];
        self.vc.view.hidden = YES;

    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Actions

- (IBAction)vkButtonAction:(UIButton *)sender {
    if (self.vkButton.isSelected) {
//        self.vkButton.selected = NO;
//        self.vkButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"light_gray"]];
        NSLog(@"YAY");
    } else {
        NSLog(@"SCOPE - %@",SCOPE);
        [VKSdk authorize:SCOPE];
        self.vkButton.selected = YES;
//        self.vkButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dark_gray"]];
        self.vkButton.backgroundColor = [UIColor colorWithRed:69.0/255.0 green:104.0/255.0 blue:142.0/255.0 alpha:1.0];
    }
}

- (IBAction)facebookButtonAction:(UIButton *)sender {
    if (self.facebookButton.isSelected) {
//        self.facebookButton.selected = NO;
//        self.facebookButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"light_gray"]];
    } else {
        [self FBLogin];
        self.facebookButton.selected = YES;
//        self.facebookButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dark_gray"]];
        self.facebookButton.backgroundColor = [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0];
    }
}



- (IBAction)rentButtonAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"Post" sender:self];
}

#pragma mark - UITavleViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ListTableViewCell alloc] init];
    }
    cell.favButton.selected = YES;
    cell.favButton.alpha = 1;
    cell.favButton.userInteractionEnabled = NO;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)test:(NSInteger)type {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arrayToFill = [[NSMutableArray alloc] init];
    NSDictionary *parameters = [[NSDictionary alloc] init];
    NSString *url = @"flats/filter";
    Server *server = [Server new];
    parameters = @{@"sorting":@"last",@"offset":@"0",@"amount":@"100",@"parameters":@"[{\"key\":\"id_user\",\"value\":\"20\", \"criterion\":\"single\"}]"};
    
    ServerRequest *requestToGet = [ServerRequest initRequest:ServerRequestTypeGET With:parameters To:url];
    [server sentToServer:requestToGet OnSuccess:^(NSDictionary *result) {
        NSDictionary *keyinresult;
        for (keyinresult in result) {
            Flat *flatToFill= [Flat new];
            flatToFill.address = [NSString stringWithFormat:@"%@ %@",keyinresult[@"street"],keyinresult[@"building"]];
            flatToFill.latitude = keyinresult[@"latitude"];
            flatToFill.longitude = keyinresult[@"longitude"];
            flatToFill.createDate = keyinresult[@"create_date"];
            flatToFill.updateDate = keyinresult[@"update_date"];
            flatToFill.ID = keyinresult[@"id"];
            NSDictionary *params = keyinresult[@"parameters"];
            NSDictionary *key;
            NSMutableDictionary *serializedParams = [NSMutableDictionary new];
            
            if(![[NSString stringWithFormat:@"%@",params] isEqual: @"<null>"])
            {
                serializedParams = params;
                flatToFill.parameters = [NSString stringWithFormat:@"%@",serializedParams];
            }
            if(![[NSString stringWithFormat:@"%@",keyinresult[@"photos"]] isEqual: @"<null>"])
            {
                NSLog(@"pisya - %@",keyinresult[@"photos"]);
                for(key in keyinresult[@"photos"])
                {
                    FlatPhoto *onePhoto = [FlatPhoto new];
                    onePhoto.url = key[@"url"];
                    onePhoto.selfdescription = key[@"description"];
                    [flatToFill.photos addObject:onePhoto];
                }
            }
            flatToFill.undegroundName = keyinresult[@"name_underground"];
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"name = %@",keyinresult[@"name_underground_line"]];
            RLMResults<UndergroundList*> *toColor = [UndergroundList objectsWithPredicate:pred];
            flatToFill.undergroundColor = toColor.firstObject.colorName;
            [arrayToFill addObject:flatToFill];
        }
        self.source = arrayToFill;
        [self.table reloadData];
    }  OrFailure:^(NSError *error) {
        
    }];
    
    
}

@end



