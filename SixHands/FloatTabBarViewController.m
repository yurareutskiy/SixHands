//
//  FloatTabBarViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/7/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "FloatTabBarViewController.h"

@interface FloatTabBarViewController ()

@property (strong, nonatomic) UIView *itemLine;
@property (strong, nonatomic) UIView *railView;
@property (assign, nonatomic) float widthItem;
@end

@implementation FloatTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.tintItemColor == nil) {
        self.tintItemColor = [UIColor colorWithRed:112.f/255.f green:85.f/255.f blue:249.f/255.f alpha:1.f];
    }
    
    if (self.backgroundColor == nil) {
        self.backgroundColor = [UIColor colorWithRed:255.f green:255.f blue:255.f alpha:1];
    }
    [self initConfigure];
    [self addRailView];
    [self configureItemLine];
    // Do any additional setup after loading the view.
}

- (void)initConfigure {
    
    self.tabBar.barTintColor = self.backgroundColor;
    
    [[UITabBar appearance] setTintColor:self.tintItemColor];

}

- (void)addRailView {
    
    if (!self.railLineHeight) {
        self.railLineHeight = 3.f;
    }
    self.railView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.railLineHeight)];
    self.railView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
//    self.railView.alpha = 1;
    [self.tabBar addSubview:self.railView];
}

- (void)configureItemLine {

    self.widthItem = self.view.frame.size.width / [self.tabBar.items count];
    self.itemLine = [[UIView alloc] initWithFrame:CGRectMake(5, 0, self.widthItem - 10, self.railLineHeight)];
    self.itemLine.backgroundColor = self.tintItemColor;
    [self.railView addSubview:self.itemLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"%@", item.title);
    float destinationX = 0;
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        UITabBarItem *tabBarItem = self.tabBar.items[i];
        if ([tabBarItem isEqual:item]) {
            destinationX = i * self.widthItem;
            break;
        }
    }
    CGRect newRect = CGRectMake(destinationX + 5, 0, self.widthItem - 10, self.railLineHeight);
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.itemLine.frame = newRect;
    } completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
