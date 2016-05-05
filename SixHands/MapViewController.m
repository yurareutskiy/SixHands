//
//  MapViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 02/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "MapViewController.h"
#import "FlatViewController.h"

@interface MapViewController () <SWRevealViewControllerDelegate>

@property (strong, nonatomic) FilterViewController *menu;
@property (strong, nonatomic) UIBarButtonItem *menuButton;
@property (strong, nonatomic) SWRevealViewController *reveal;
@property (strong, nonatomic) GMSMarker *selectedMarker;
@property (strong, nonatomic) NSArray *markersArray;
@property (strong, nonatomic) NSArray *markersCoordinates;
@property (strong, nonatomic) UIGestureRecognizer *recognozer;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@end

@implementation MapViewController {
    CLLocationManager *locationManager;
    GMSMapView *mapView;
    GMSCameraPosition *camera;
    GClusterManager *clusterManager_;
    float mapZoom;
    BOOL upDown;
    BOOL isMenuOpen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isMenuOpen = false;
    self.shadowView.backgroundColor=[UIColor clearColor];
//    self.shadowView.userInteractionEnabled = NO;
    self.shadowView.hidden = true;

    mapZoom = 15;
    upDown = false;
    
    self.reveal.delegate = self;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    NSLog(@"HERE WE ARE");
    // for debugging
    CLLocationCoordinate2D point = CLLocationCoordinate2DMake(55.711331, 37.475160);
    
    
//    camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:mapZoom];
        camera = [GMSCameraPosition cameraWithLatitude:point.latitude longitude:point.longitude zoom:mapZoom];
    
    mapView = [GMSMapView mapWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height) camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.selectedMarker.icon = [UIImage imageNamed:@"active"];
    [mapView setMinZoom:6 maxZoom:90];
    [self.view insertSubview:mapView atIndex:0];
    mapView.delegate = self;
    
    clusterManager_ = [GClusterManager managerWithMapView:mapView
                                                algorithm:[[NonHierarchicalDistanceBasedAlgorithm alloc] init]
                                                 renderer:[[GDefaultClusterRenderer alloc] initWithMapView:mapView]];
    
    [mapView setDelegate:clusterManager_];
    
    self.markersCoordinates = @[[Spot initWithLoction:CLLocationCoordinate2DMake(55.711331, 37.470100)], [Spot initWithLoction:CLLocationCoordinate2DMake(55.711301, 37.475162)], [Spot initWithLoction:CLLocationCoordinate2DMake(55.712301, 37.475149)]];
    
    for (Spot *spot in self.markersCoordinates) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.title = @"First pin";
        marker.snippet = @"Just to check";
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
        // marker1.map = mapView;
        marker.icon = [UIImage imageNamed:@"pin"];
        marker.position = spot.location;
        spot.marker = marker;
        [clusterManager_ addItem:spot];

    }
    
//    GMSMarker *marker1 = [[GMSMarker alloc] init];
//    marker1.position = CLLocationCoordinate2DMake(56.065000, 36.780000);
//    marker1.title = @"First pin";
//    marker1.snippet = @"Just to check";
//    marker1.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
//    // marker1.map = mapView;
//    marker1.icon = [UIImage imageNamed:@"pin"];
//    
//    Spot* spot1 = [[Spot alloc] init];
//    spot1.location = marker1.position;
//    spot1.marker = marker1;
//    
//    [clusterManager_ addItem:spot1];
//    
//    GMSMarker *marker2 = [[GMSMarker alloc] init];
//    marker2.position = CLLocationCoordinate2DMake(56.064000, 36.787000);
//    marker2.title = @"First pin";
//    marker2.snippet = @"Just to check";
//    marker2.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
//    //marker2.map = mapView;
//    
//    Spot* spot2 = [[Spot alloc] init];
//    spot2.location = marker2.position;
//    spot2.marker = marker2;
//    
//    [clusterManager_ addItem:spot2];
//    
//    GMSMarker *marker3 = [[GMSMarker alloc] init];
//    marker3.position = CLLocationCoordinate2DMake(56.066000, 36.789000);
//    marker3.title = @"First pin";
//    marker3.snippet = @"Just to check";
//    marker3.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
//    
//    //marker3.map = mapView;
//    
//    Spot* spot3 = [[Spot alloc] init];
//    spot3.location = marker3.position;
//    spot3.marker = marker3;
//    spot3.marker.tappable = YES;
//    
//    [clusterManager_ addItem:spot3];
    
    [self setNeedsStatusBarAppearanceUpdate];
    [self preferredStatusBarStyle];
    
    [clusterManager_ cluster];
    [clusterManager_ setDelegate:self];
    
    self.navigationItem.title = @"Карта";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0]];
    
    [self configureMenu];

    // Do any additional setup after loading the view.
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    UIViewController *viweVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapView"];
    viweVC.view.frame = CGRectMake(0, 0, 250, 120);
    UIView *view = viweVC.view;
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor grayColor].CGColor;

    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 130)];
    [container addSubview:view];
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 250, 10)];
    emptyView.backgroundColor = [UIColor clearColor];
    [container addSubview:emptyView];
//    [view setBackgroundColor:[UIColor greenColor]];
    [mapView moveCamera:[GMSCameraUpdate scrollByX:0 Y:-30]];

    return container;
}


-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    NSLog(@"%@", marker);
    
    if (self.selectedMarker) {
        self.selectedMarker.icon = [UIImage imageNamed:@"pin"];
    }
    marker.icon = [UIImage imageNamed:@"active"];
    self.selectedMarker = marker;

//    [mapView moveCamera:[GMSCameraUpdate scrollByX:0 Y:-30]];
    return NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)configureMenu {
    
    self.reveal = self.revealViewController;

    
   if (!self.reveal) {
        return;
    } 
    
    // Add gesture recognizer
    self.recognozer = self.revealViewController.panGestureRecognizer;
//    [self.recognozer addTarget:self action:@selector(rightMenu)];
    self.recognozer.enabled = false;
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightMenu)];
    [self.shadowView addGestureRecognizer:swipe];
    
    // Set menu button
    self.menuButton = [[UIBarButtonItem alloc] initWithImage:[self imageWithImage:[UIImage imageNamed:@"filter"] scaledToSize:CGSizeMake(20, 20)]
                                                       style:UIBarButtonItemStyleDone
                                                      target:self
                                                      action:@selector(rightMenu)];
    
    self.navigationItem.rightBarButtonItem = self.menuButton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
}

- (void)rightMenu {
    [self.revealViewController rightRevealToggle:nil];
    if (self.tapRecognizer == nil) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightMenu)];
        [self.view addGestureRecognizer:self.tapRecognizer];
    }
    if (isMenuOpen) {
        isMenuOpen = false;
        self.recognozer.enabled = false;
        self.shadowView.hidden = true;
        self.tapRecognizer.enabled = false;
    } else {
        self.tapRecognizer.enabled = true;
        isMenuOpen = true;
        self.shadowView.hidden = false;
//        self.shadowView.userInteractionEnabled = YES;
        self.recognozer.enabled = true;
        
    }
    
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
    GMSCameraUpdate* zoomCamera = [GMSCameraUpdate zoomIn];
    [mapView animateWithCameraUpdate:zoomCamera];
}

- (IBAction)minusButton:(UIButton *)sender {
    GMSCameraUpdate* unzoomCamera = [GMSCameraUpdate zoomOut];
    [mapView animateWithCameraUpdate:unzoomCamera];
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    [self performSegueWithIdentifier:@"showflat" sender:marker.userData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showflat"]){
        FlatViewController *vc=segue.destinationViewController;
        vc.navigationItem.title = self.address;
    }
}

#pragma mark - SWRevealViewControllerDelegate
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position {
    NSLog(@"open");
}

- (BOOL)revealControllerTapGestureShouldBegin:(SWRevealViewController *)revealController {
    NSLog(@"TAAAP");
    return YES;
}


@end
