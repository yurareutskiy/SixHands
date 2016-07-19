//
//  FloatTabBarViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/7/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "FloatTabBarViewController.h"
#import "ListViewController.h"
@interface FloatTabBarViewController ()

@property (strong, nonatomic) UIView *itemLine;
@property (strong, nonatomic) UIView *railView;
@property (assign, nonatomic) float widthItem;
@end

@implementation FloatTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if (self.tintItemColor == nil) {
        self.tintItemColor = [UIColor colorWithRed:79.f/255.f green:238.f/255.f blue:197.f/255.f alpha:1.f];
    }
    
    if (self.backgroundColor == nil) {
        self.backgroundColor = [UIColor colorWithRed:57.f/255.f green:70.f/255.f blue:76.f/255.f alpha:1];
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName : [UIColor colorWithRed:79.f/255.f green:238.f/255.f blue:197.f/255.f alpha:1.f]} forState:UIControlStateSelected];
    
    [self.tabBarController setSelectedIndex:1];
    
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
    self.railView.backgroundColor = [UIColor colorWithRed:57.f green:70.f blue:76.f alpha:0.5];
//    self.railView.alpha = 1;
    [self.tabBar addSubview:self.railView];
}

- (void)configureItemLine {

    self.widthItem = self.view.frame.size.width / [self.tabBar.items count];
    self.itemLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.widthItem, self.railLineHeight)];
    self.itemLine.backgroundColor = self.tintItemColor;
    [self.railView addSubview:self.itemLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"%@", item.title);
    item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAutomatic];
    float destinationX = 0;
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        UITabBarItem *tabBarItem = self.tabBar.items[i];
        if ([tabBarItem isEqual:item]) {
            destinationX = i * self.widthItem;
            break;
        }
    }
    CGRect newRect = CGRectMake(destinationX, 0, self.widthItem, self.railLineHeight);
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.itemLine.frame = newRect;
    } completion:nil];
}

-(void)trigerTwo:(NSDictionary*) dict
{
    NSLog(@"trigerTwo - %@",dict);
    UINavigationController* vc = (UINavigationController*) [self.viewControllers objectAtIndex:0];
    [(ListViewController*)[[vc childViewControllers] firstObject] trigerThree:dict];

//    [(ListViewController*)[self.viewControllers objectAtIndex:3] trigerThree:dict];
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
