//
//  ScrollFlatTableViewCell.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/10/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flat.h"

@interface ScrollFlatTableViewCell : UITableViewCell <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property Flat* flat;
- (void)setScrollViewWithWidth:(float)width;
- (NSString*)formattedStringWithPrice:(NSString*)price;
@end
