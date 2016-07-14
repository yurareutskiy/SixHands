//
//  PhotoCollectionViewCell.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/18/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "ThirdScrollViewController.h"
@implementation PhotoCollectionViewCell

- (instancetype)init {
    PhotoCollectionViewCell *cell = [super init];
    cell.image.layer.cornerRadius = 15.f;
    cell.image.layer.masksToBounds = YES;
//    [cell.image setImage:[UIImage imageNamed:@"kvartira2"]];
    return cell;
}

-(void)prepareForReuse {

}

@end
