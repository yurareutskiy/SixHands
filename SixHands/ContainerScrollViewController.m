//
//  ContainerScrollViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ContainerScrollViewController.h"
#import "FirstScrollViewController.h"
#import "SecondScrollViewController.h"
#import "ThirdScrollViewController.h"

@interface ContainerScrollViewController ()

@end

@implementation ContainerScrollViewController {
    FirstScrollViewController *firstVC;
    SecondScrollViewController *secondVC;
    ThirdScrollViewController *thirdVC;
    
    CGFloat buttonHeight;
    NSInteger currentController;
    UIButton *bottomButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addButton];
    currentController = 0;
    self.starusBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"white_nav_square"]];
}

-(void)viewWillAppear:(BOOL)animated {
    [self addViewControllers];
}

- (void)addButton {
    buttonHeight = 50;
    bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - buttonHeight, self.view.frame.size.width, buttonHeight)];
    bottomButton.backgroundColor = [UIColor darkGrayColor];
    [bottomButton setTitle:@"Далее" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)addViewControllers {
    self.scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    firstVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstVC"];
    secondVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
    thirdVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdVC"];
    self.scroll.contentSize = CGSizeMake(3 * self.view.frame.size.width, self.view.frame.size.height);
    self.scroll.contentOffset = CGPointZero;
    NSArray *viewControllers = @[firstVC, secondVC, thirdVC];
    for (int i = 0; i < [viewControllers count]; i++) {
        UIView *viewVC = ((UIViewController*)[viewControllers objectAtIndex:i]).view;
        CGRect rect = viewVC.frame;
        rect.origin.x = i * self.view.frame.size.width;
        viewVC.frame = rect;
        [self.scroll addSubview:viewVC];
    }
    self.scroll.scrollEnabled = NO;
    self.scroll.pagingEnabled = YES;
}

- (void)nextPage {
    if (currentController == 2) {
        return;
    } else if (currentController == 0) {
        self.backButton.hidden = NO;
    } else if (currentController == 1) {
        [bottomButton setTitle:@"Закончить" forState:UIControlStateNormal];
    }
    currentController++;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.counterLabel.text = [NSString stringWithFormat:@"ШАГ %d ИЗ 3", currentController + 1];
            self.backButton.alpha = 1;
            self.scroll.contentOffset = CGPointMake(currentController * self.view.frame.size.width, 0);
    } completion:nil];

}


-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backButtonAction:(UIButton *)sender {
    currentController--;
    if (currentController == 0) {
        self.backButton.hidden = YES;
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backButton.alpha = 0;
            self.scroll.contentOffset = CGPointMake(currentController * self.view.frame.size.width, 0);
        } completion:nil];
    } else if (currentController == 1) {
        [bottomButton setTitle:@"Далее" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.scroll.contentOffset = CGPointMake(currentController * self.view.frame.size.width, 0);
        } completion:nil];
    }
    self.counterLabel.text = [NSString stringWithFormat:@"ШАГ %d ИЗ 3", currentController + 1];
}
@end


