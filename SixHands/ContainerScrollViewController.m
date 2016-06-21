//
//  ContainerScrollViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ContainerScrollViewController.h"
#import "FirstScrollViewController.h"
#import "SecondScrollViewController.h"
#import "ThirdScrollViewController.h"
#import "Server.h"
#import "ServerResponse.h"
#import "AFNetworking.h"

@interface ContainerScrollViewController ()

@end

@implementation ContainerScrollViewController {
    
    FirstScrollViewController *firstVC;
    SecondScrollViewController *secondVC;
    ThirdScrollViewController *thirdVC;
    
    CGFloat buttonHeight;
    NSInteger currentController;
    UIButton *bottomButton;

}

-(void)addAddress:(Flat *)item {
    self.flatToPost = [Flat alloc];
    self.flatToPost.address = item.address;
}

-(void)addParams:(NSDictionary *)item {
    _parameters = [NSDictionary new];
    _parameters = item;
    NSLog(@"PARAMS - %@",_parameters);
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self addButton];
     currentController = 0;
    self.starusBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dark_gray"]];
    self.bar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dark_gray"]];
    [self.bar setBackgroundImage:[UIImage new]
    forBarMetrics:UIBarMetricsDefault];
    self.bar.shadowImage = [UIImage new];
    self.bar.translucent = YES;
    [self.bar setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0]];

    [self configureCircles];
    self.backButton.image = nil;

}

- (void)configureCircles {
    self.indicatorContainer.backgroundColor = [UIColor clearColor];
    for (UIView *circle in self.circles) {
        circle.backgroundColor = [UIColor clearColor];
        circle.layer.borderWidth = 2;
        if (circle.tag == 100) {
            circle.layer.borderColor = [UIColor colorWithRed:79.f/255.f green:238.f/255.f blue:197.f/255.f alpha:1.f].CGColor;
        } else {
            circle.layer.borderColor = [UIColor lightGrayColor].CGColor;
        }
        circle.layer.cornerRadius = circle.frame.size.height / 2;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [self addViewControllers];
}

- (void)addButton {
    buttonHeight = 50;
    bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - buttonHeight, self.view.frame.size.width, buttonHeight)];
    bottomButton.backgroundColor = [UIColor darkGrayColor];
    [bottomButton setTitle:@"Далее" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)addViewControllers {
    self.scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    firstVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstVC"];
    firstVC.delegate = self;
    secondVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
    secondVC.delegate = self;
    thirdVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdVC"];
    self.scroll.contentSize = CGSizeMake(3 * self.view.frame.size.width, self.view.frame.size.height);
    self.scroll.contentOffset = CGPointZero;
    NSArray *viewControllers = @[firstVC, secondVC, thirdVC];
    for (int i = 0; i < [viewControllers count]; i++) {
        UIView *viewVC = ((UIViewController*)[viewControllers objectAtIndex:i]).view;
        CGRect rect = viewVC.frame;
        rect.origin.x = i * self.view.frame.size.width;
        viewVC.frame = rect;
        [self.scroll addSubview:viewVC];
    }
    self.scroll.scrollEnabled = NO;
    self.scroll.pagingEnabled = YES;

}

- (void)nextPage {

    if ([firstVC.searchField.text length] >0){
    if (currentController == 2) {
        [thirdVC savePrice];
        [self postFlat];
         [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        return;
    } else if (currentController == 0) {

    } else if (currentController == 1) {
        [secondVC saveParams];

        [bottomButton setTitle:@"Закончить" forState:UIControlStateNormal];
    }

    CGRect rect = ((UIView*)self.lines[currentController]).frame;
    rect.size.width = 25;
    currentController++;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        ((UIView*)self.lines[currentController - 1]).frame = rect;
        self.counterLabel.text = [NSString stringWithFormat:@"ШАГ %ld ИЗ 3", currentController + 1];
//            self.backButton.alpha = 1;
                self.backButton.image = [UIImage imageNamed:@"left"];
            self.scroll.contentOffset = CGPointMake(currentController * self.view.frame.size.width, 0);
    } completion:^(BOOL finished){
        if (finished) {
            ((UIView*)self.circles[currentController]).layer.borderColor = [UIColor colorWithRed:79.f/255.f green:238.f/255.f blue:197.f/255.f alpha:1.f].CGColor;
        }
    }];
    } else {
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                           message:@"Введите адрес."
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
    }
}


-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backButtonAction:(UIButton *)sender {
    currentController--;
    if (currentController == 0) {
//        self.backButton.hidden = YES;
        self.backButton.image = nil;
        ((UIView*)self.circles[currentController + 1]).layer.borderColor = [UIColor lightGrayColor].CGColor;
        CGRect rect = ((UIView*)self.lines[currentController]).frame;
        rect.size.width = 0;
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    ((UIView*)self.lines[currentController]).frame = rect;
            self.scroll.contentOffset = CGPointMake(currentController * self.view.frame.size.width, 0);
        } completion:nil];
    } else if (currentController == 1) {
        ((UIView*)self.circles[currentController + 1]).layer.borderColor = [UIColor lightGrayColor].CGColor;
        [bottomButton setTitle:@"Далее" forState:UIControlStateNormal];
        CGRect rect = ((UIView*)self.lines[currentController]).frame;
        rect.size.width = 0;

        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    ((UIView*)self.lines[currentController]).frame = rect;
            self.scroll.contentOffset = CGPointMake(currentController * self.view.frame.size.width, 0);
        } completion:nil];
    }
    self.counterLabel.text = [NSString stringWithFormat:@"ШАГ %ld ИЗ 3", currentController + 1];
    [self.view endEditing:YES];

}

-(void)postFlat{
    NSDictionary *parameters = [[NSDictionary alloc] init];
    NSUserDefaults *ud = [[NSUserDefaults alloc] initWithSuiteName:@"flatToPost"];

    NSMutableDictionary *paramsForm = [[NSMutableDictionary alloc] init];
    paramsForm[@"29"] = [ud objectForKey:@"square"];
    paramsForm[@"30"] = [ud objectForKey:@"price"];
    NSDictionary *temp = [[NSDictionary alloc] init];
    NSMutableArray *paramsArray = [NSMutableArray new];
    NSMutableString *jsonString = [[NSMutableString alloc] init];
    [jsonString appendString:@"["];
    
    for(temp in _parameters)
    {
        NSString *oneParam= [[NSString alloc] initWithFormat:@"{\"id\":\"%@\",\"value\":\"%@\"}",temp,[_parameters objectForKey:temp]];
        [paramsArray addObject:oneParam];
    }
    if([paramsArray count]!= 0){
        [jsonString appendString:[paramsArray firstObject]];
        for (int index = 1; index < [paramsArray count]; index++) {
            [jsonString appendString:@","];
            [jsonString appendString:[paramsArray objectAtIndex:index]];
        }
    }
    
    [jsonString appendString:@"]"];
    NSLog(@"JSON String- %@",jsonString);
    parameters = @{@"id_user":/*[Sud objectForKey:@"user_id"]*/@"1", @"id_city": @"1",@"id_underground":@"1",@"street":[ud objectForKey:@"address"],@"building":@"",@"longitude": [ud objectForKey:@"longitude"],@"latitude":[ud objectForKey:@"latitude"],@"parameters":jsonString,@"image_urls":@"[{\"url\":\"404\",\"description\":\"404\"}]"};
    ServerRequest *requestToPost = [ServerRequest initRequest:ServerRequestTypePOST With:parameters To:@"flat"];
    Server *server = [Server new];
    [server sentToServer:requestToPost OnSuccess:^(NSDictionary *result) {
        NSLog(@"Result - %@",result);
    }  OrFailure:^(NSError *error) {
     
        NSLog(@"ERR %@",error);
    }];

}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end


