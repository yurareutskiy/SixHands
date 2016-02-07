//
//  FloatTabBarViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/7/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatTabBarViewController : UITabBarController <UITabBarDelegate>

@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *tintItemColor;
@property (assign, nonatomic) float railLineHeight;

@end
