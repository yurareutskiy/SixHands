//
//  CUTVERSION_FilterViewController.m
//  SixHands
//
//  Created by Андрей on 25.07.16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CUTVERSION_FilterViewController.h"

@interface CUTVERSION_FilterViewController ()

@end

@implementation CUTVERSION_FilterViewController {
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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.scrollView.delegate = self;
    //    [self.scrollView setScrollEnabled:YES];
    //    [self.scrollView setContentSize:CGSizeMake(288.0, 900.0)];
    
    self.tableView.rowHeight = 44.0;
    
    
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
    [self.view1.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.view1.layer setBorderWidth: 1.5f];
    
    self.view2.layer.cornerRadius = 15.f;
    [self.view2.layer setMasksToBounds:YES];
    [self.view2.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.view2.layer setBorderWidth: 1.5f];
    
    self.view3.layer.cornerRadius = 15.f;
    [self.view3.layer setMasksToBounds:YES];
    [self.view3.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.view3.layer setBorderWidth: 1.5f];
    
    self.view4.layer.cornerRadius = 15.f;
    [self.view4.layer setMasksToBounds:YES];
    [self.view4.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.view4.layer setBorderWidth: 1.5f];
    
    [self.aloneRoom.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.aloneRoom.layer setBorderWidth: 1.5f];
    [self.aloneRoom.layer setCornerRadius:7.f];
    
    [self.room1.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room1.layer setBorderWidth: 1.5f];
    [self.room1.layer setCornerRadius:7.f];
    
    [self.room2.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room2.layer setBorderWidth: 1.5f];
    [self.room2.layer setCornerRadius:7.f];
    
    [self.room3.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room3.layer setBorderWidth: 1.5f];
    [self.room3.layer setCornerRadius:7.f];
    
    [self.room4.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room4.layer setBorderWidth: 1.5f];
    [self.room4.layer setCornerRadius:7.f];
    
    [self.room.layer setBorderColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0].CGColor];
    [self.room.layer setBorderWidth: 1.5f];
    [self.room.layer setCornerRadius:7.f];
    
    //    self.revealViewController.rightViewRevealWidth = self.view.frame.size.width - 70.0;
    self.revealViewController.rightViewRevealWidth = 288.f;
    //    self.view.frame = CGRectMake(61.0,0.0, self.revealViewController.rightViewRevealWidth, 558.0 + self.tableView.rowHeight * 10);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController
                                                              action:@selector(revealToggle:)];
    //    [self.view addGestureRecognizer:singleFingerTap];
    
    [self.revealViewController.frontViewController.view addGestureRecognizer:singleFingerTap];
    
    //
    //    self.view.frame = CGRectMake(61.0,0.0, self.revealViewController.rightViewRevealWidth, 558.0 + self.tableView.rowHeight * 10);
    self.view.frame = CGRectMake(61.0,0.0, self.revealViewController.rightViewRevealWidth, 900.0);
    //    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.revealViewController.rightViewRevealWidth, 558.0 + self.tableView.rowHeight * 10);
    //    self.scrollView.contentSize = CGSizeMake(self.revealViewController.rightViewRevealWidth, 558.0 + self.tableView.rowHeight * 10); //self.tableView.frame.size.height);
    //    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.rowHeight * 10);
    //    self.scrollView.frame = CGRectMake(self.view.frame.size.width-288.0 ,0.0, self.revealViewController.rightViewRevealWidth, 558.0 + self.tableView.rowHeight * 10);
    self.scrollView.contentSize = CGSizeMake(self.revealViewController.rightViewRevealWidth, 1300.0); //self.tableView.frame.size.height);
    self.scrollView.frame = CGRectMake(self.view.frame.size.width-288.0 ,0.0, self.revealViewController.rightViewRevealWidth, 900.0);
    //    CGRect rect = self.scrollView.frame;
    //    rect.origin.y=0.0;
    //    rect.origin.x=55.0;
    //    self.scrollView.frame = rect;
    
    //    NSLog(@"%f", self.tableView.rowHeight);
    //    NSLog(@"%f", self.scrollView.contentSize.height);
    //     NSLog(@"%f", self.scrollView.contentSize.width);
    //     NSLog(@"%f", self.contentView.frame.size.width);
    //     NSLog(@"%f", self.view.frame.size.width);
    //    NSLog(@"%f", self.revealViewController.rightViewRevealWidth);
}

-(void)viewDidDisappear:(BOOL)animated {
    [self.revealViewController.frontViewController.view removeGestureRecognizer:singleFingerTap];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.revealViewController.frontViewController.view addGestureRecognizer:swipe];
    [self paramsToSend];
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

- (IBAction)view1:(UIButton *)sender {
    if (!view1b) {
        view1b = YES;
        [self.view1 setImage:[UIImage imageNamed:@"animals"] forState:UIControlStateNormal];
        [self.view1 setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
    } else {
        view1b = NO;
        [self.view1 setImage:[UIImage imageNamed:@"animalsWhite"] forState:UIControlStateNormal];
        [self.view1 setBackgroundColor:[UIColor clearColor]];
    }
}

- (IBAction)view2:(UIButton *)sender {
    if (!view2b) {
        view2b = YES;
        [self.view2 setImage:[UIImage imageNamed:@"subway1-4"] forState:UIControlStateNormal];
        [self.view2 setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
    } else {
        view2b = NO;
        [self.view2 setImage:[UIImage imageNamed:@"subway1-3"] forState:UIControlStateNormal];
        [self.view2 setBackgroundColor:[UIColor clearColor]];
    }
}

- (IBAction)view3:(UIButton *)sender {
    if (!view3b) {
        view3b = YES;
        [self.view3 setImage:[UIImage imageNamed:@"sofa"] forState:UIControlStateNormal];
        [self.view3 setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
    } else {
        view3b = NO;
        [self.view3 setImage:[UIImage imageNamed:@"sofaWhite"] forState:UIControlStateNormal];
        [self.view3 setBackgroundColor:[UIColor clearColor]];
    }
}

- (IBAction)view4:(UIButton *)sender {
    if (!view4b) {
        view4b = YES;
        [self.view4 setImage:[UIImage imageNamed:@"group4-6"] forState:UIControlStateNormal];
        [self.view4 setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
    } else {
        view4b = NO;
        [self.view4 setImage:[UIImage imageNamed:@"group4-5"] forState:UIControlStateNormal];
        [self.view4 setBackgroundColor:[UIColor clearColor]];
    }
}

- (IBAction)aloneRoom:(UIButton *)sender {
    if (!aloneRoomb) {
        aloneRoomb = YES;
        roomb = NO;
        [self.aloneRoom setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.aloneRoom setTitleColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor clearColor]];
        [self.room setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        aloneRoomb = NO;
        roomb = NO;
        [self.aloneRoom setBackgroundColor:[UIColor clearColor]];
        [self.aloneRoom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

- (IBAction)room1:(UIButton *)sender {
    if (!room1b) {
        room1b = YES;
        roomb = NO;
        [self.room1 setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room1 setTitleColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor clearColor]];
        [self.room setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        room1b = NO;
        roomb = NO;
        [self.room1 setBackgroundColor:[UIColor clearColor]];
        [self.room1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)room2:(UIButton *)sender {
    if (!room2b) {
        room2b = YES;
        roomb = NO;
        [self.room2 setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room2 setTitleColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor clearColor]];
        [self.room setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        room2b = NO;
        roomb = NO;
        [self.room2 setBackgroundColor:[UIColor clearColor]];
        [self.room2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)room3:(UIButton *)sender {
    if (!room3b) {
        room3b = YES;
        roomb = NO;
        [self.room3 setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room3 setTitleColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor clearColor]];
        [self.room setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        room3b = NO;
        roomb = NO;
        [self.room3 setBackgroundColor:[UIColor clearColor]];
        [self.room3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)room4:(UIButton *)sender {
    if (!room4b) {
        room4b = YES;
        roomb = NO;
        [self.room4 setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room4 setTitleColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.room setBackgroundColor:[UIColor clearColor]];
        [self.room setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        room4b = NO;
        roomb = NO;
        [self.room4 setBackgroundColor:[UIColor clearColor]];
        [self.room4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)room:(UIButton *)sender {
    if (!roomb) {
        roomb = YES;
        [self.room setBackgroundColor:[UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0]];
        [self.room setTitleColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.room4 setBackgroundColor:[UIColor clearColor]];
        [self.room4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.room3 setBackgroundColor:[UIColor clearColor]];
        [self.room3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.room2 setBackgroundColor:[UIColor clearColor]];
        [self.room2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.room1 setBackgroundColor:[UIColor clearColor]];
        [self.room1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.aloneRoom setBackgroundColor:[UIColor clearColor]];
        [self.aloneRoom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        aloneRoomb = NO;
        room1b = NO;
        room2b = NO;
        room3b = NO;
        room4b = NO;
    } else {
        roomb = NO;
        [self.room setBackgroundColor:[UIColor clearColor]];
        [self.room setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
-(void)paramsToSend
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    if(view1b)
    {
        [params setObject:@"YES" forKey:@"viewOne"];
    }
    if(view2b)
    {
        [params setObject:@"YES" forKey:@"viewTwo"];
    }
    if(view3b)
    {
        [params setObject:@"YES" forKey:@"viewThree"];
    }
    if(view4b)
    {
        [params setObject:@"YES" forKey:@"viewFour"];
    }
    if(aloneRoomb)
    {
        [params setObject:@"YES" forKey:@"aloneRoom"];
    }
    if(room1b)
    {
        [params setObject:@"YES" forKey:@"oneRoom"];
    }
    if(room2b)
    {
        [params setObject:@"YES" forKey:@"twoRoom"];
    }
    if(room3b)
    {
        [params setObject:@"YES" forKey:@"threeRoom"];
    }
    if(room4b)
    {
        [params setObject:@"YES" forKey:@"fourRoom"];
    }
    [params setObject:[[NSString alloc]initWithFormat:@"%f",[[self priceSlider] selectedMinimum]] forKey:@"priceMin"];
    [params setObject:[[NSString alloc]initWithFormat:@"%f",[[self priceSlider] selectedMaximum]] forKey:@"priceMax"];
    [params setObject:[[NSString alloc]initWithFormat:@"%f",[[self squareSlider] selectedMinimum]] forKey:@"squareMin"];
    [params setObject:[[NSString alloc]initWithFormat:@"%f",[[self squareSlider] selectedMaximum]] forKey:@"squareMax"];
    
    [[self revealViewController] triger:params];
}
- (IBAction)type:(UIButton *)sender {
}

- (IBAction)params:(UIButton *)sender {
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"filterCell"]; // Вставить название для ячейки!
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end