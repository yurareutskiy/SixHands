//
//  FlatViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 03/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "FlatViewController.h"
#import "ScrollFlatTableViewCell.h"

@interface FlatViewController ()

@end

@implementation FlatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cofirmButton.backgroundColor = [UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0];

    self.table.delegate = self;
    self.table.dataSource = self;

}

-(void)viewWillAppear:(BOOL)animated {

}

-(void)viewDidAppear:(BOOL)animated {
    self.capView.hidden = YES;

    [UIView animateWithDuration:0.3 animations:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200.f;
    }
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = (ScrollFlatTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ScrollCell"];
        float width = self.view.frame.size.width;
        [(ScrollFlatTableViewCell*)cell setScrollViewWithWidth:width];
    }
    return cell;

}




@end
