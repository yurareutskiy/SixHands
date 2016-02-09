//
//  SubwayView.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/9/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubwayView : UIView

@property (strong, nonatomic) NSString *subwayName;
@property (strong, nonatomic) NSString *line;
@property (strong, nonatomic) UIColor *lineColor;
@property (assign, nonatomic) float diametr;
@property (strong, nonatomic) UIView *dotLine;
@property (strong, nonatomic) UILabel *subwayTitle;
@property (assign, nonatomic) float offsetDot;
@end
