//
//  ContainerScrollViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelViewController.h"
#import "Flat.h"
#import "FirstScrollViewController.h"


@interface ContainerScrollViewController : UIViewController <FirstScrollViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *starusBarView;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property  Flat* flatToPost;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
- (IBAction)backButtonAction:(id)sender;
-(void)postFlat;
@property (weak, nonatomic) IBOutlet UIView *indicatorContainer;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *circles;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *lines;
- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeBarButton;

@end
