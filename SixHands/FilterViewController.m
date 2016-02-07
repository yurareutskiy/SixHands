//
//  FilterViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController {
    UITapGestureRecognizer *singleFingerTap;
    BOOL view1b;
    BOOL view2b;
    BOOL view3b;
    BOOL view4b;
    
    BOOL aloneRoomb;
    BOOL room1b;
    BOOL room2b;
    BOOL room3b;
    BOOL room4b;
    BOOL roomb;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.revealViewController.delegate = self;
    
    view1b = NO;
    view2b = NO;
    view3b = NO;
    view4b = NO;
    
    aloneRoomb = NO;
    room1b = NO;
    room2b = NO;
    room3b = NO;
    room4b = NO;
    roomb = NO;
    
    self.view1.layer.cornerRadius = 15.f;
    [self.view1.layer setMasksToBounds:YES];
    self.view2.layer.cornerRadius = 15.f;
    [self.view2.layer setMasksToBounds:YES];
    self.view3.layer.cornerRadius = 15.f;
    [self.view3.layer setMasksToBounds:YES];
    self.view4.layer.cornerRadius = 15.f;
    [self.view4.layer setMasksToBounds:YES];
    
    [self.aloneRoom.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.aloneRoom.layer setBorderWidth: .5f];
    [self.aloneRoom.layer setCornerRadius:7.f];
    
    [self.room1.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room1.layer setBorderWidth: .5f];
    [self.room1.layer setCornerRadius:7.f];
    
    [self.room2.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room2.layer setBorderWidth: .5f];
    [self.room2.layer setCornerRadius:7.f];
    
    [self.room3.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room3.layer setBorderWidth: .5f];
    [self.room3.layer setCornerRadius:7.f];
    
    [self.room4.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room4.layer setBorderWidth: .5f];
    [self.room4.layer setCornerRadius:7.f];
    
    [self.room.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room.layer setBorderWidth: .5f];
    [self.room.layer setCornerRadius:7.f];
    
    self.revealViewController.rightViewRevealWidth = self.view.frame.size.width - 70.0;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController
                                            action:@selector(revealToggle:)];
    //    [self.view addGestureRecognizer:singleFingerTap];
    
    [self.revealViewController.frontViewController.view addGestureRecognizer:singleFingerTap];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    [self.revealViewController.frontViewController.view removeGestureRecognizer:singleFingerTap];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(revealToggle:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.revealViewController.frontViewController.view addGestureRecognizer:swipe];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)view1:(UIButton *)sender {
    if (!view1b) {
        view1b = YES;
        [self.view1 setImage:[UIImage imageNamed:@"animals"] forState:UIControlStateNormal];
    } else {
        view1b = NO;
        [self.view1 setImage:[UIImage imageNamed:@"animalsWhite"] forState:UIControlStateNormal];
    }
}

- (IBAction)view2:(UIButton *)sender {
    if (!view2b) {
        view2b = YES;
        [self.view2 setImage:[UIImage imageNamed:@"metro"] forState:UIControlStateNormal];
    } else {
        view2b = NO;
        [self.view2 setImage:[UIImage imageNamed:@"metroWhite"] forState:UIControlStateNormal];
    }
}

- (IBAction)view3:(UIButton *)sender {
    if (!view3b) {
        view3b = YES;
        [self.view3 setImage:[UIImage imageNamed:@"sofa"] forState:UIControlStateNormal];
    } else {
        view3b = NO;
        [self.view3 setImage:[UIImage imageNamed:@"sofaWhite"] forState:UIControlStateNormal];
    }
}

- (IBAction)view4:(UIButton *)sender {
    if (!view4b) {
        view4b = YES;
        [self.view4 setImage:[UIImage imageNamed:@"friends"] forState:UIControlStateNormal];
    } else {
        view4b = NO;
        [self.view4 setImage:[UIImage imageNamed:@"friendsWhite"] forState:UIControlStateNormal];
    }
}

- (IBAction)aloneRoom:(UIButton *)sender {
    if (!aloneRoomb) {
        aloneRoomb = YES;
        roomb = NO;
        [self.aloneRoom setBackgroundColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.aloneRoom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor whiteColor]];
        [self.room setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        aloneRoomb = NO;
        roomb = NO;
        [self.aloneRoom setBackgroundColor:[UIColor whiteColor]];
        [self.aloneRoom setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

}

- (IBAction)room1:(UIButton *)sender {
    if (!room1b) {
        room1b = YES;
        roomb = NO;
        [self.room1 setBackgroundColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor whiteColor]];
        [self.room setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        room1b = NO;
        roomb = NO;
        [self.room1 setBackgroundColor:[UIColor whiteColor]];
        [self.room1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (IBAction)room2:(UIButton *)sender {
    if (!room2b) {
        room2b = YES;
        roomb = NO;
        [self.room2 setBackgroundColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor whiteColor]];
        [self.room setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        room2b = NO;
        roomb = NO;
        [self.room2 setBackgroundColor:[UIColor whiteColor]];
        [self.room2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (IBAction)room3:(UIButton *)sender {
    if (!room3b) {
        room3b = YES;
        roomb = NO;
        [self.room3 setBackgroundColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor whiteColor]];
        [self.room setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        room3b = NO;
        roomb = NO;
        [self.room3 setBackgroundColor:[UIColor whiteColor]];
        [self.room3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (IBAction)room4:(UIButton *)sender {
    if (!room4b) {
        room4b = YES;
        roomb = NO;
        [self.room4 setBackgroundColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor whiteColor]];
        [self.room setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        room4b = NO;
        roomb = NO;
        [self.room4 setBackgroundColor:[UIColor whiteColor]];
        [self.room4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (IBAction)room:(UIButton *)sender {
    if (!roomb) {
        roomb = YES;
        [self.room setBackgroundColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.room4 setBackgroundColor:[UIColor whiteColor]];
        [self.room4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.room3 setBackgroundColor:[UIColor whiteColor]];
        [self.room3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.room2 setBackgroundColor:[UIColor whiteColor]];
        [self.room2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.room1 setBackgroundColor:[UIColor whiteColor]];
        [self.room1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.aloneRoom setBackgroundColor:[UIColor whiteColor]];
        [self.aloneRoom setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        aloneRoomb = NO;
        room1b = NO;
        room2b = NO;
        room3b = NO;
        room4b = NO;
    } else {
        roomb = NO;
        [self.room setBackgroundColor:[UIColor whiteColor]];
        [self.room setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (IBAction)type:(UIButton *)sender {
}

- (IBAction)params:(UIButton *)sender {
}
@end
