//
//  PhotoCollectionViewCell.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/18/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol  DeleteCollectionViewCellDelegate <NSObject>
//
//-(void)deletePhotoCollectionViewCell:(NSString*)tet;
//
//@end
@interface PhotoCollectionViewCell : UICollectionViewCell
//@property (weak,nonatomic) id <DeleteCollectionViewCellDelegate> delegate1;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@end
