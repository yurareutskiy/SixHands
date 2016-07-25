//
//  ThirdScrollViewController.h
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flat.h"
#import "PhotoCollectionViewCell.h"
//@protocol  WorkWithCollectionViewCellDelegate <NSObject>
//
//-(void)deletePhotoCollectionViewCell:(UIButton*)sender;
//-(void)addNewPhotoCollectionViewCell;
//@end
@interface ThirdScrollViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//@property (weak,nonatomic) id <WorkWithCollectionViewCellDelegate> delegatecell;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) Flat* flatToFill;
@property (weak, nonatomic) IBOutlet UITextView *dopInfoTextView;
- (IBAction)deletePhoto:(UIButton*)sender;
//@property (weak, nonatomic) IBOutlet UIButton *closeAction;
- (IBAction)addPhoto:(UIButton*)sender;
-(void)savePrice;
@end
