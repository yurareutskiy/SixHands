//
//  FirstScrollViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "FirstScrollViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface FirstScrollViewController () <GMSAutocompleteViewControllerDelegate>

@end

@implementation FirstScrollViewController {
    BOOL isStart;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isStart = NO;
    [self.hiddenField becomeFirstResponder];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.searchField action:@selector(resignFirstResponder)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (range.location == 0 && [self.searchField.text length] == 0) {
        self.magnifier.hidden = YES;
    } else if (range.location == 0 && [self.searchField.text length] > 0) {
        self.magnifier.hidden = NO;
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    
    acController.delegate = self;
    acController.navigationController.navigationBar.backgroundColor = [UIColor redColor];
//    acController.navigationController.navigationBarHidden = YES;
    [self presentViewController:acController animated:YES completion:nil];
}


#pragma mark - GMSAutocompleteViewControllerDelegate

/**
 * Called when a place has been selected from the available autocomplete predictions.
 * @param viewController The |GMSAutocompleteViewController| that generated the event.
 * @param place The |GMSPlace| that was returned.
 */
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    NSLog(@"Place: %@", place);
    
    NSUserDefaults *ud = [[NSUserDefaults alloc] initWithSuiteName:@"flatToPost"];
    [ud setObject:[[NSString alloc] initWithFormat:@"%f",place.coordinate.latitude ]forKey:@"latitude"];
    [ud setObject:place.placeID forKey:@"placeID"];
    [ud setObject:place.name forKey:@"address"];
    self.flatToFill = [[Flat alloc] init];
    self.flatToFill.address = place.name;
       [ud setObject:[[NSString alloc] initWithFormat:@"%f",place.coordinate.longitude ]forKey:@"longitude"];
    self.searchField.text = place.formattedAddress;
    [self dismissViewControllerAnimated:YES completion:nil];

    [self.delegate addAddress:self.flatToFill];
}

/**
 * Called when a non-retryable error occurred when retrieving autocomplete predictions or place
 * details. A non-retryable error is defined as one that is unlikely to be fixed by immediately
 * retrying the operation.
 * <p>
 * Only the following values of |GMSPlacesErrorCode| are retryable:
 * <ul>a
 * <li>kGMSPlacesNetworkError
 * <li>kGMSPlacesServerError
 * <li>kGMSPlacesInternalError
 * </ul>
 * All other error codes are non-retryable.
 * @param viewController The |GMSAutocompleteViewController| that generated the event.
 * @param error The |NSError| that was returned.
 */

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    NSLog(@"Error: %@", [error debugDescription]);
}

/**
 * Called when the user taps the Cancel button in a |GMSAutocompleteViewController|.
 * @param viewController The |GMSAutocompleteViewController| that generated the event.
 */
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    NSLog(@"wasCancelled");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
