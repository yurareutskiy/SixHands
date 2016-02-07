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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.revealViewController.delegate = self;
    
    view1b = NO;
    view2b = NO;
    view3b = NO;
    view4b = NO;
    
    self.view1.layer.cornerRadius = 15.f;
    [self.view1.layer setMasksToBounds:YES];
    self.view2.layer.cornerRadius = 15.f;
    [self.view2.layer setMasksToBounds:YES];
    self.view3.layer.cornerRadius = 15.f;
    [self.view3.layer setMasksToBounds:YES];
    self.view4.layer.cornerRadius = 15.f;
    [self.view4.layer setMasksToBounds:YES];
    
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
@end
