//
//  ListViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 06/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@property (strong, nonatomic) FilterViewController *menu;
@property (strong, nonatomic) UIBarButtonItem *menuButton;
@property (strong, nonatomic) SWRevealViewController *reveal;

@end

@implementation ListViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"Список";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0]];
    
    [self.viewNew setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:135.0/255.0 blue:141.0/255.0 alpha:1.0]];
    [self.buttonNew setTitleColor:[UIColor colorWithRed:78.0/255.0 green:236.0/255.0 blue:196.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self configureMenu];
    
    // Do any additional setup after loading the view.
}

- (void)configureMenu {
    
    self.reveal = self.revealViewController;
    
    if (!self.reveal) {
        return;
    }
    
    // Add gesture recognizer
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Set menu button
    self.menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"]
                                                       style:UIBarButtonItemStyleDone
                                                      target:self.revealViewController
                                                      action:@selector(rightRevealToggle:)];
    
    self.navigationItem.rightBarButtonItem = self.menuButton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
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

- (IBAction)buttonNew:(UIButton *)sender {

        [self.viewNew setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:135.0/255.0 blue:141.0/255.0 alpha:1.0]];
        [self.buttonNew setTitleColor:[UIColor colorWithRed:78.0/255.0 green:236.0/255.0 blue:196.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.viewPopular setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
        [self.popularButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.viewFav setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
        [self.favButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (IBAction)popularButton:(UIButton *)sender {
    
    [self.viewPopular setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:135.0/255.0 blue:141.0/255.0 alpha:1.0]];
    [self.popularButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:236.0/255.0 blue:196.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.viewNew setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.buttonNew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewFav setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.favButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (IBAction)favButton:(UIButton *)sender {
    
    [self.viewFav setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:135.0/255.0 blue:141.0/255.0 alpha:1.0]];
    [self.favButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:236.0/255.0 blue:196.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.viewPopular setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.popularButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewNew setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.buttonNew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
@end
