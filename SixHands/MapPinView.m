//
//  MapPinView.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/22/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "MapPinView.h"
#import "FlatViewController.h"

@interface MapPinView ()

@end

@implementation MapPinView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];

}


- (void)configureView {
    
    // self configure
    
    self.view.layer.cornerRadius = 10.f;

    // avatars; round them
    for (UIImageView *imageView in self.avatars) {
        imageView.layer.cornerRadius = imageView.frame.size.height / 2;
        imageView.layer.masksToBounds = YES;
    }
    
    // formating view with others peoples
    self.othersPeople.layer.cornerRadius = self.othersPeople.frame.size.height / 2;
    self.othersPeople.layer.borderColor = [UIColor colorWithRed:79.f/255.f green:238.f/255.f blue:197.f/255.f alpha:1.f].CGColor;
    self.othersPeople.layer.borderWidth = 1.f;
    
    // formating string with price
    self.price.text = [self formattedStringWithPrice:@"124000"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Format raw string with price to string with number, what separated by whitespace and in th end to append sign of rouble.

- (NSString*)formattedStringWithPrice:(NSString*)price {
    if ([[price substringFromIndex:[price length] - 1] isEqualToString:@"₽"]) {
        return price;
    }
    self.price.text = @"";
    NSInteger lenghtString = [price length];
    NSMutableString *resultString = [NSMutableString stringWithString:@""];
    NSInteger counter = lenghtString;
    for (int i = 0; i < lenghtString; i++) {
        char ch = [price characterAtIndex:i];
        if (counter % 3 == 0 && lenghtString != counter) {
            [resultString appendString:@" "];
        }
        [resultString appendString:[NSString stringWithFormat:@"%c", ch]];
        counter--;
    }
    [resultString appendString:@" ₽"];
    return resultString;
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
