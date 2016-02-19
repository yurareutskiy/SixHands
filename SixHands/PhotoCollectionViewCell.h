//
//  PhotoCollectionViewCell.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/18/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
- (IBAction)closeAction:(UIButton *)sender;

@end
