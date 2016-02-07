//
//  ListViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 06/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"Список";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:122.0/255.0 green:91.0/255.0 blue:250.0/255.0 alpha:1.0]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (ListTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"listCell"];
    
    cell.name.titleLabel.numberOfLines = 2;
    cell.name.titleLabel.minimumScaleFactor = 6.f;
    cell.name.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    cell.address.numberOfLines = 1;
    [cell.address setMinimumScaleFactor: 10.f];
    cell.address.adjustsFontSizeToFitWidth = YES;
    
    cell.hands.layer.cornerRadius = 15.f;
    cell.hands.layer.borderColor = [UIColor grayColor].CGColor;
    cell.hands.layer.borderWidth = 0.5f;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
