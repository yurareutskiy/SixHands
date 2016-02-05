//
//  MapViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (strong, nonatomic) FilterViewController *menu;
@property (strong, nonatomic) UIBarButtonItem *menuButton;
@property (strong, nonatomic) SWRevealViewController *reveal;

@end

@implementation MapViewController {
    CLLocationManager *locationManager;
    GMSMapView *mapView;
    GMSCameraPosition *camera;
    float mapZoom;
    BOOL upDown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mapZoom = 15;
    upDown = false;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    camera = [GMSCameraPosition
                                 cameraWithLatitude:locationManager.location.coordinate.latitude
                                 longitude:locationManager.location.coordinate.longitude
                                 zoom:mapZoom];
    
    mapView = [GMSMapView mapWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height) camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    [mapView setMinZoom:6 maxZoom:90];
    [self.view insertSubview:mapView atIndex:0];
    mapView.delegate = self;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(56.064049, 36.788179);
    marker.title = @"First pin";
    marker.snippet = @"Just to check";
    marker.map = mapView;
    
    self.navigationItem.title = @"Аренда";
    
    [self setNeedsStatusBarAppearanceUpdate];
    [self preferredStatusBarStyle];
    [self configureMenu];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.layer.shadowColor = [[UIColor grayColor] CGColor];
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.navigationController.navigationBar.layer.shadowRadius = 1.0f;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.5f;
    
    self.navigationItem.rightBarButtonItem = self.menuButton;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// Обращаться к GMSUpdateCamera

#pragma mark - Настройки кнопок

- (IBAction)plusButton:(UIButton *)sender {
    mapZoom = camera.zoom;
    mapZoom += 1;
    [mapView animateToZoom:mapZoom];
}

- (IBAction)minusButton:(UIButton *)sender {
    mapZoom = camera.zoom;
    mapZoom -= 1;
    [mapView animateToZoom:mapZoom];
}

- (IBAction)upDownButton:(UIButton *)sender {
    if (!upDown) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.upDownTop.constant -= 300.0;
            
            self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y - 300.0, self.tableView.frame.size.width, self.tableView.frame.size.height + 300.0);
            self.tableView.rowHeight = 200.0;
            [self.tableView reloadData];
            self.upDownButton.frame = CGRectMake(self.upDownButton.frame.origin.x, self.upDownButton.frame.origin.y - 300.0, self.upDownButton.frame.size.width, self.upDownButton.frame.size.height);
            
        } completion:^ (BOOL finished){
            upDown = true;
        }];
        
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.tableView.rowHeight = 90.0;
            [self.tableView reloadData];
            self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y + 300.0, self.tableView.frame.size.width, self.tableView.frame.size.height - 300.0);
            self.upDownButton.frame = CGRectMake(self.upDownButton.frame.origin.x, self.upDownButton.frame.origin.y + 300.0, self.upDownButton.frame.size.width, self.upDownButton.frame.size.height);
            
            
        } completion:^(BOOL finished){
            self.upDownTop.constant += 300.0;
            upDown = false;
        }];
    }
}

#pragma mark - Настройки таблицы

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"flatCell"];
    return cell;
}

#pragma mark - Найстройки карты

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    NSLog(@"MARKER..... %@",marker);
    self.tableView.hidden = NO;
    self.upDownButton.hidden = NO;
    return NO;
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"COORDINATE..... %f, %f",coordinate.latitude, coordinate.longitude);
    self.tableView.hidden = YES;
    self.upDownButton.hidden = YES;
}

@end
