//
//  SubwayView.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/9/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "SubwayView.h"

@implementation SubwayView {
    float middleY;
}


- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor clearColor];
//    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    if (self.offsetDot == 0) {
        self.offsetDot = 5;
    }
    [self drawLineDot];
    [self drawLabel];
}

- (void)drawLineDot {
    middleY = CGRectGetMidY(self.bounds);
    self.diametr = 10;
    self.dotLine = [[UIView alloc] initWithFrame:CGRectMake(0, middleY - (self.diametr / 2), self.diametr, self.diametr)];
    self.dotLine.layer.cornerRadius = self.diametr / 2;
    self.dotLine.layer.borderColor = [UIColor blackColor].CGColor;
//    self.dotLine.layer.borderWidth = 1;
    self.dotLine.backgroundColor = [UIColor redColor];
    [self addSubview:self.dotLine];
}

- (void)drawLabel {
    float xPoint = self.offsetDot + self.diametr;
    CGRect rectLabel = CGRectMake(xPoint, middleY - (self.diametr / 2) - 2, self.frame.size.width - xPoint - 5, self.diametr + 3);
    self.subwayTitle = [[UILabel alloc] initWithFrame:rectLabel];
    self.subwayTitle.text = (self.subwayName ? self.subwayName : @"Кропоткинская");
    self.subwayTitle.font = [UIFont fontWithName:@"Lato-Light" size:14];
    self.subwayTitle.adjustsFontSizeToFitWidth = YES;
    self.subwayTitle.minimumScaleFactor = 0.3;
    self.subwayTitle.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self addSubview:self.subwayTitle];
}


@end
