//
//  SecondScrollViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASValueTrackingSlider.h"

@interface SecondScrollViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
      UITextField* activeField; // указывает на активный элемент ввода
}
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *roomAmountButtons;
- (IBAction)roomNumberAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UITableView *table;

- (IBAction)sliderChangeValue:(UISlider *)sender;

@end
