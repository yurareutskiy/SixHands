//
//  ScrollFlatTableViewCell.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/10/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ScrollFlatTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FlatPhoto.h"

@implementation ScrollFlatTableViewCell {
    NSMutableArray *pageImages;
    NSArray *pageViews;
    float pageWidth;
}

#pragma mark - Init

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UIScrollViewDelegate

- (void)setScrollViewWithWidth:(float)width {
    pageWidth = width;
    self.scroll.delegate = self;
    self.scroll.bounces = NO;
    FlatPhoto* onePhoto = [FlatPhoto new];
    pageImages = [[NSMutableArray alloc] init];
    if(self.flat.photos.count == nil)
    {
        [pageImages addObject:@"404"];
    }
    else
    {
        for (onePhoto in self.flat.photos)
        {
            NSLog(@"one url -%@",onePhoto.url);
            [pageImages addObject:onePhoto.url];
        }

    }
        int pageCount = [pageImages count];

//    self.pageController.pageIndicatorTintColor = [UIColor whiteColor];
//    self.pageController.currentPageIndicatorTintColor =
    self.pageController.currentPage = 0;
    self.pageController.numberOfPages = pageCount;
    
    NSMutableArray *mutablePageViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < pageCount; i++) {
        [mutablePageViews addObject:[[UIImageView alloc] init]];
    }
    pageViews = mutablePageViews;
    
    self.scroll.contentSize = CGSizeMake(pageWidth * pageCount, 240);
    
    [self loadVisiblePages];
    
}

- (void)loadVisiblePages {
    NSLog(@"Content = %f",self.scroll.contentOffset.x);
    int page = floor((self.scroll.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0));
    NSLog(@"PAGE = %d",page);
    self.pageController.currentPage = page;
    
    int previousPage = page - 1;
    int nextPage = page + 1;
    NSLog(@"previousPage = %d",previousPage);
    NSLog(@"nextPage = %d",nextPage);
    for (int i = 0; i < previousPage; ++i) {
        [self purgePage:i];
    }
    
    for (int i = previousPage; i < nextPage; i++) {
        [self loadPage:i];
    }
    
//    for (int i = page; i < [pageImages count]; ++i) {
//        [self purgePage:i];
//    }
}

- (void)loadPage:(int)page {
    if (page < 0 || page > [pageImages count]) {
        return;
    }
//    NSLog(@"cnt - %@",pageViews.count);
    if (((UIImageView*)pageViews[page]).image) {
        
    } else {
        CGRect frame = self.scroll.bounds;
        frame.origin.x = pageWidth * page;
        frame.origin.y = 0.0;
        frame.size.height = pageWidth * 0.75;
        frame = CGRectInset(frame, 0.0, 0.0);
        
        UIImageView *newPageView = [[UIImageView alloc] init];
        newPageView.contentMode = UIViewContentModeScaleAspectFill;
        newPageView.frame = frame;
        [newPageView sd_setImageWithURL:[NSURL URLWithString:[pageImages objectAtIndex:page]]
                               placeholderImage:[UIImage imageNamed:@"loading.gif"]];
        [self.scroll addSubview:newPageView];
        NSMutableArray *muatbleViews = [NSMutableArray arrayWithArray:pageViews];
        muatbleViews[page] = newPageView;
        pageViews = muatbleViews;
    }
}

- (void)purgePage:(int)page {

    if (page < 0 || page >= [pageImages count]) {
        return;
    }
    
    if (((UIImageView*)pageViews[page]).image) {
        [pageViews[page] removeFromSuperview];
        NSMutableArray *muatbleViews = [NSMutableArray arrayWithArray:pageViews];
        ((UIImageView*)muatbleViews[page]).image = nil;
        pageViews = muatbleViews;
    }

}
-(void)updatePages
{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self loadVisiblePages];
}

- (NSString*)formattedStringWithPrice:(NSString*)price {
    if ([[price substringFromIndex:[price length] - 1] isEqualToString:@"₽"]) {
        return price;
    }
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



@end
