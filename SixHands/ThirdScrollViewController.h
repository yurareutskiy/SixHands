//
//  ThirdScrollViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flat.h"

@interface ThirdScrollViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) Flat* flatToFill;

-(void)savePrice;
@end
