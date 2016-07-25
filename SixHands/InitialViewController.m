//
//  InitialViewController.m
//  SixHands
//
//  Created by Андрей on 25.07.16.
//  Copyright © 2016 Styleru. All rights reserved.
//
#import <CoreData/NSEntityDescription.h>
#import "InitialViewController.h"


@interface InitialViewController ()
@end
@implementation InitialViewController{
    BOOL tutorial_was_shown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *integerData = [ud objectForKey:@"enterfirststart"];
    if ((integerData != nil)&&([integerData isEqual:@"true"])) {
            if([ud objectForKey:@"isLogined"])
            {
               [self performSegueWithIdentifier:@"toMain" sender:self];
            }
    }else{
        [ud setObject:@"true" forKey:@"enterfirststart"];
        [self performSegueWithIdentifier:@"toOnboarding" sender:self];
    }
}
@end