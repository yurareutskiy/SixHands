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

@property (strong, nonatomic) SettingsViewController *vc;
@property (strong, nonatomic) UIView *blackoutView;

@end

@implementation ProfileViewController

#pragma mark - init custom

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.userInteractionEnabled = NO;
    
    self.navigationItem.title = @"Профиль";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0]];
//    self.backPhoto.image = [[UIImage imageNamed:@"avatar2"] imageWithGaussianBlur];
//    self.backPhoto.backgroundColor = [UIColor colorWithRed:221.f/255.f green:222.f/255.f blue:226.f/255.f alpha:1.f];
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
    
    // Do any additional setup after loading the view.
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

//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];

    

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
        self.vkButton.selected = NO;
        self.vkButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"light_gray"]];
    } else {
        self.vkButton.selected = YES;
//        self.vkButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dark_gray"]];
        self.vkButton.backgroundColor = [UIColor colorWithRed:69.0/255.0 green:104.0/255.0 blue:142.0/255.0 alpha:1.0];
    }
}

- (IBAction)facebookButtonAction:(UIButton *)sender {
    if (self.facebookButton.isSelected) {
        self.facebookButton.selected = NO;
        self.facebookButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"light_gray"]];
    } else {
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


@end



