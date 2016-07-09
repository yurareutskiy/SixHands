//
//  OnboardingScrollItem.h
//  SixHands
//
//  Created by Sizov Andrey on 08.07.16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnboardingScrollItem : UIView

-(instancetype)initWithContent:(NSString*)content AndImage:(UIImage*)image WithScreenSize:(CGSize)screenSize;


@property (assign, nonatomic) NSInteger itemIndex;

@end
