//
//  FavViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "FavViewController.h"

@interface FavViewController ()

@end

@implementation FavViewController

#pragma mark - Init configure

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"Избранное";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0]];
    
    [self customNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)customNavBar {
    UIBarButtonItem *settingsItem = [[UIBarButtonItem alloc] initWithImage:nil
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(addFlat:)];
    settingsItem.image = [self imageWithImage:[UIImage imageNamed:@"add139"] scaledToSize:CGSizeMake(20, 20)];
    
    self.navigationItem.rightBarButtonItem = settingsItem;
}




#pragma mark - Actions
- (void)addFlat:(id)sender {
    NSLog(@"Added");
}


#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"favCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toFlat" sender:self];
}




@end
