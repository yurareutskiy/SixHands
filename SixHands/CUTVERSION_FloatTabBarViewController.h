//
//  CUTVERSION_FloatTabBarViewController.h
//  SixHands
//
//  Created by Андрей on 25.07.16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatTabBarViewController.h"

@interface CUTVERSION_FloatTabBarViewController : FloatTabBarViewController <UITabBarDelegate>

@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *tintItemColor;
@property (assign, nonatomic) float railLineHeight;

-(void)trigerTwo:(NSDictionary*) dict;
@end
