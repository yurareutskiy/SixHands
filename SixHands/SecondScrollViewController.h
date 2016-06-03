//
//  SecondScrollViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASValueTrackingSlider.h"
#import "Flat.h"

@class SecondScrollViewController;

@protocol SecondScrollViewControllerDelegate <NSObject>

- (void)addParams:(NSDictionary *)item;

@end

@interface SecondScrollViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
      UITextField* activeField; // указывает на активный элемент ввода
}
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *roomAmountButtons;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, weak) id <SecondScrollViewControllerDelegate> delegate;
@property Flat* flatToFill;

- (IBAction)roomNumberAction:(id)sender;
-(void)saveParams;
- (IBAction)sliderChangeValue:(UISlider *)sender;

@end
