//
//  OnboardingViewController.m
//  SixHands
//
//  Created by Sizov Andrey on 08.07.16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "OnboardingViewController.h"
#import "OnboardingScrollItem.h"

@interface OnboardingViewController ()

@property (strong, nonatomic) NSArray *viewsArray;

@end

@implementation OnboardingViewController{
    BOOL last;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewsArray = [self createViewsArray];
    [self setLayout];

    last = false;
    [self.swipe addTarget:self action:@selector(swipeAction:)];
    [self.backSwipe addTarget:self action:@selector(swipeAction:)];
    
    [self.pageControl setNumberOfPages:[_viewsArray count]];
    
}
- (NSArray*)createViewsArray {
    NSArray *contentArray = [self createContentArray];
    NSMutableArray *arrayTemp = [[NSMutableArray alloc] initWithArray:@[]];
    for (int i = 0; i < [contentArray count]; i++) {
        NSArray *contentItem = contentArray[i];
        OnboardingScrollItem *view = [[OnboardingScrollItem alloc] initWithContent:contentItem[0] AndImage:[UIImage imageNamed: contentItem[1]] WithScreenSize:self.view.frame.size];
        
        CGRect rect = view.frame;
        
        CGFloat xPoint = i * self.view.frame.size.width;
        rect.origin.x = xPoint;
        view.frame = rect;
        
        [arrayTemp addObject:view];
    }
    
    return arrayTemp;
}

- (void)swipeAction:(UISwipeGestureRecognizer*)sender {
    NSLog(@"%@", sender);
    BOOL back;
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        back = NO;
    } else {
        back = YES;
    }
    [self swipeOnBack:back];
}

- (NSArray*)createContentArray {
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[]];
    [array addObject:@[@"Регистрируйтесь через социальные сети", @"1"]];
    [array addObject:@[@"Следите за актуальными предложениями", @"2"]];
    [array addObject:@[@"Общайтесь напрямую с владельцем", @"3"]];
    [array addObject:@[@"Сдавайте собственную квартиру", @"4"]];
    return array;
}

- (void) setLayout {
    [self.scroll setBackgroundColor:[UIColor colorWithRed:79.f/238.f green:197.f/255.f blue:183.f/255.f alpha:1.f]];
    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width * [_viewsArray count], self.view.frame.size.height);
    for (OnboardingScrollItem *item in self.viewsArray) {
        NSLog(@"%@", NSStringFromCGRect(item.frame));
        [self.scroll addSubview:item];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"firststart" sender:self];
  
}

-(IBAction)nextButtonAction:(id)sender {
    [self swipeOnBack:NO];
    NSLog(@"page - %ld",(long)self.pageControl.currentPage);
    NSLog(@"total - %ld",(long)self.viewsArray.count);
    if(last){
        [self dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"firststart" sender:self];
    }
    if(self.pageControl.currentPage == [self.viewsArray count] - 1)
    {
        last = true;
    }
}

- (void)swipeOnBack:(BOOL)isBackSwipe {
    CGPoint pointOffset = self.scroll.contentOffset;
    if (isBackSwipe && pointOffset.x > 0) {
        pointOffset.x -= self.view.frame.size.width;
        [self.pageControl setCurrentPage:self.pageControl.currentPage - 1];
        if(last){
           [self.doneButton setHidden:YES];
        }
    } else if (isBackSwipe == NO && pointOffset.x < self.view.frame.size.width * ([self.viewsArray count] - 1)) {
        pointOffset.x += self.view.frame.size.width;
        [self.pageControl setCurrentPage:self.pageControl.currentPage + 1];
    } else {
        return;
    }
    if (self.pageControl.currentPage == [self.viewsArray count] - 1) {
        [self.doneButton setHidden:YES];
        [self.nextButton setHidden:NO];
        [self.nextButton setTitle:@"Приступить!" forState:0];
       
    } else if (self.pageControl.currentPage == [self.viewsArray count] - 2) {
        if(last == false){
            [self.doneButton setHidden:NO];
        }
        [self.nextButton setHidden:NO];
    } 
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.scroll setContentOffset:pointOffset];
    }];
}

@end

