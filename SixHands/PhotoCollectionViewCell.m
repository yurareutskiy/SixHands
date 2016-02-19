//
//  PhotoCollectionViewCell.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/18/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (instancetype)init {
    PhotoCollectionViewCell *cell = [super init];
    cell.image.layer.cornerRadius = 15.f;
    cell.image.layer.masksToBounds = YES;
    return cell;
}

-(void)prepareForReuse {

}

- (IBAction)closeAction:(UIButton *)sender {
}
@end
