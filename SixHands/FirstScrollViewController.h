//
//  FirstScrollViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flat.h"

@class FirstScrollViewController;

@protocol FirstScrollViewControllerDelegate <NSObject>

- (void)addAddress:(Flat *)item;

@end

@interface FirstScrollViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIImageView *magnifier;
@property (weak, nonatomic) IBOutlet UITextField *hiddenField;
@property (weak, nonatomic) NSNumber* longitude;
@property (weak, nonatomic) NSNumber* latitude;
@property (weak, nonatomic) NSString* address;
@property (nonatomic, weak) id <FirstScrollViewControllerDelegate> delegate;

@property Flat* flatToFill;

@end