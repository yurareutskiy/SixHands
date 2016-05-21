//
//  ThirdScrollViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ThirdScrollViewController.h"
#import "PhotoCollectionViewCell.h"
#import "AddPhotoCollectionViewCell.h"

@interface ThirdScrollViewController ()

@end

@implementation ThirdScrollViewController {
    NSInteger numberOfRows;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.collectionView.frame = CGRectMake(0.0, 240.0, self.view.frame.size.width, self.view.frame.size.height-290);
    numberOfRows = 30;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}



- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSUserDefaults *ud = [[NSUserDefaults alloc] initWithSuiteName:@"flatToPost"];
    [ud setObject:@"100" forKey:@"price"];
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return numberOfRows;
}
-(void) savePrice
{
    NSUserDefaults *ud = [[NSUserDefaults alloc] initWithSuiteName:@"flatToPost"];
    [ud setObject:_priceTextField.text forKey:@"price"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger last = numberOfRows - 1;
    if (indexPath.row == last) {
        AddPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addPhoto" forIndexPath:indexPath];
        if (!cell) {
            cell = [[AddPhotoCollectionViewCell alloc] init];
        }
        return cell;
        
    } else {
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
        if (!cell) {
            cell = [[PhotoCollectionViewCell alloc] init];
        }
        cell.image.layer.cornerRadius = 10.f;
        cell.image.layer.masksToBounds = YES;
        return cell;
    }
}


@end
