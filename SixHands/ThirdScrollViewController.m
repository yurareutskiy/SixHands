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
@property (strong, nonatomic) PhotoCollectionViewCell *pcvc;
@end

@implementation ThirdScrollViewController {
    NSInteger numberOfRows;
    NSMutableArray* photoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    photoArray = [[NSMutableArray alloc]init];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.collectionView.frame = CGRectMake(0.0, 240.0, self.view.frame.size.width, self.view.frame.size.height-290);
//    self.dopInfoTextField.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 20);
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
    return [photoArray count]+1;
}

-(void) savePrice
{
    NSUserDefaults *ud = [[NSUserDefaults alloc] initWithSuiteName:@"flatToPost"];
    [ud setObject:_priceTextField.text forKey:@"price"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger last = [photoArray count];
    if (indexPath.row == last) {
        AddPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addPhoto" forIndexPath:indexPath];
//        if (!cell) {
//            cell = [[AddPhotoCollectionViewCell alloc] init];
//        }
        return cell;
        
    } else {
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
//        if (!cell) {
//            cell = [[PhotoCollectionViewCell alloc] init];
//        }
        cell.image.layer.cornerRadius = 10.f;
        cell.image.layer.masksToBounds = YES;
        [cell.image setImage:photoArray[indexPath.row]];
        cell.deleteButton.tag = indexPath.row;
        return cell;
    }
}


- (IBAction)deletePhoto:(UIButton*)sender {
    [photoArray removeObjectAtIndex:sender.tag];
    [self.collectionView reloadData];
}

- (IBAction)addPhoto:(UIButton*)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [photoArray addObject:image];
    [self.collectionView reloadData];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
