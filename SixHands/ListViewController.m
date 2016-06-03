//
//  ListViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 06/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ListViewController.h"
#import "FlatViewController.h"
#import "Server.h"
#import "DataManager.h"
#import "Flat.h"
#import "Params.h"

@interface ListViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) FilterViewController *menu;
@property (strong, nonatomic) UIBarButtonItem *menuButton;
@property (strong, nonatomic) SWRevealViewController *reveal;
@property (strong, nonatomic) NSArray *source;

@end

@implementation ListViewController {

    NSArray *newArray;
    NSArray *popularArray;
    NSArray *favoritesArray;
    
}

- (void)viewDidLoad {
    
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    [self test:1];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"Список";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0]];
    
    [self.viewNew setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:135.0/255.0 blue:141.0/255.0 alpha:1.0]];
    [self.buttonNew setTitleColor:[UIColor colorWithRed:78.0/255.0 green:236.0/255.0 blue:196.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self configureMenu];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    // Add to Realm with transaction

    
    Server *server = [Server new];
    ServerRequest *requestToPost = [ServerRequest initRequest:ServerRequestTypeGET With:nil
                                                           To:@"parameters"];
    [server sentToServer:requestToPost OnSuccess:^(NSDictionary *result) {
        NSLog(@"PARAMS - %@",result);
        NSDictionary *key = [[NSDictionary alloc] init];
        for (key in result)
        {
            Params *oneParam = [[Params alloc] init];
            oneParam.ID = key[@"id"];
            oneParam.name = key[@"name"];
            [realm beginWriteTransaction];
            [realm addObject:oneParam];
            [realm commitWriteTransaction];
        }

    }  OrFailure:^(NSError *error) {
        
    }];

    // Open the Realm with the configuration
    
    NSLog(@"REALM - %@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    UISwipeGestureRecognizer *filterSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(rightRevealToggle:)];
    filterSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:filterSwipe];
    [super viewDidLoad];    // Do any additional setup after loading the view.
}



- (void)test:(NSInteger)type {
    
    NSMutableArray *arrayToFill = [[NSMutableArray alloc] init];
    NSDictionary *parameters = [[NSDictionary alloc] init];
    Server *server = [Server new];
    switch (type) {
        case 1:
        {parameters = @{@"target": @"filter", @"sorting": @"last",@"offset":@"0",@"amount":@"100"};}
            
            break;
        case 2:
        {parameters = @{@"target": @"filter", @"sorting": @"popular",@"offset":@"0",@"amount":@"100"};}
            break;
        case 3:
        {parameters = @{@"target": @"favourites",@"offset":@"0",@"amount":@"100",@"id_user":@"3"};}
            break;
        default:
        {parameters = @{@"target": @"favourites",@"offset":@"0",@"amount":@"100",@"id_user":@"3"};}
            break;
    }

    ServerRequest *requestToPost = [ServerRequest initRequest:ServerRequestTypeGET With:parameters To:@"flat"];
    [server sentToServer:requestToPost OnSuccess:^(NSDictionary *result) {
        NSDictionary *key;
            for (key in result) {
            Flat *flatToFill= [Flat new];
            flatToFill.address = [NSString stringWithFormat:@"%@ %@",key[@"street"],key[@"building"]];
            flatToFill.latitude = key[@"latitude"];
            flatToFill.longitude = key[@"longitude"];
            NSDictionary *params = key[@"parameters"];
            NSDictionary *param;
            if(![[NSString stringWithFormat:@"%@",params] isEqual: @"<null>"])
            {
                for(param in params)
                {
                    flatToFill.price = param[@"30"];
                }
            }
            [arrayToFill addObject:flatToFill];
          
        }
        self.source = arrayToFill;
        [self.tableView reloadData];
    }  OrFailure:^(NSError *error) {
        
    }];


}


- (void)configureMenu {
    
    self.reveal = self.revealViewController;
    
    if (!self.reveal) {
        return;
    }
    
    // Add gesture recognizer
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Set menu button
    self.menuButton = [[UIBarButtonItem alloc] initWithImage:[self imageWithImage:[UIImage imageNamed:@"filter"] scaledToSize:CGSizeMake(20, 20)]
                                                       style:UIBarButtonItemStyleDone
                                                      target:self.revealViewController
                                                      action:@selector(rightRevealToggle:)];
    
    self.navigationItem.rightBarButtonItem = self.menuButton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}
- (void) viewDidAppear:(BOOL)animated{
    NSLog(@"Appeard");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



#pragma mark - Actions 

- (IBAction)buttonNew:(UIButton *)sender {

        [self.viewNew setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:135.0/255.0 blue:141.0/255.0 alpha:1.0]];
        [self.buttonNew setTitleColor:[UIColor colorWithRed:78.0/255.0 green:236.0/255.0 blue:196.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.viewPopular setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
        [self.popularButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.viewFav setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
        [self.favButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self test:1];
    [self.tableView reloadData];
}

- (IBAction)popularButton:(UIButton *)sender {
    
    [self.viewPopular setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:135.0/255.0 blue:141.0/255.0 alpha:1.0]];
    [self.popularButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:236.0/255.0 blue:196.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.viewNew setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.buttonNew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewFav setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.favButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self test:2];
    [self.tableView reloadData];
}

- (IBAction)favButton:(UIButton *)sender {
    
    [self.viewFav setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:135.0/255.0 blue:141.0/255.0 alpha:1.0]];
    [self.favButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:236.0/255.0 blue:196.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.viewPopular setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.popularButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewNew setBackgroundColor:[UIColor colorWithRed:162.0/255.0 green:165.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.buttonNew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self test:3];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FlatViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FlatVC"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (ListTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"listCell"];
    if([[self.source objectAtIndex:indexPath.item] address] != nil)
    {
        cell.address.text = [[self.source objectAtIndex:indexPath.item] address];
    }
    
    if([[self.source objectAtIndex:indexPath.item] price] != nil)
    {
        cell.price.text = [[self.source objectAtIndex:indexPath.item] price];
    }else{
        cell.price.text = @"-";
    }
    
//    if ([[self.source objectAtIndex:indexPath.item] subway_name]) {
//        
//    }
//    cell.subway.subwayName = [[self.source objectAtIndex:indexPath.item] subway_name];
//
    if([[self.source objectAtIndex:indexPath.item] square] != nil)
    {
        cell.square.text = [[NSString alloc] initWithFormat:@"%@ кв. м.",[[self.source objectAtIndex:indexPath.item] square]];
    }
    NSLog(@"TEST - %ld AND %@",(long)indexPath.item,[[self.source objectAtIndex:indexPath.item] price]);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.source count];
}



@end
