//
//  FirstScrollViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstScrollViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIImageView *magnifier;
@property (weak, nonatomic) IBOutlet UITextField *hiddenField;


@end
