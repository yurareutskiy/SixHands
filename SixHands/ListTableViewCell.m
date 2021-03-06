//
//  ListTableViewCell.m
//  SixHands
//
//  Created by Anton Scherbakov on 07/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//
#import "Server.h"
#import "ListTableViewCell.h"
#import "FavouriteFlats.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.moreFriendsLabel.layer.cornerRadius = 10.5f;
    self.moreFriendsLabel.layer.borderColor = [UIColor colorWithRed:79.f/255.f green:238.f/255.f blue:197.f/255.f alpha:1.f].CGColor;
    self.moreFriendsLabel.layer.borderWidth = 1.f;
    
    self.avatar1.layer.cornerRadius = self.avatar1.frame.size.width / 2.0;
    self.avatar2.layer.cornerRadius = self.avatar2.frame.size.width / 2.0;
    self.avatar3.layer.cornerRadius = self.avatar3.frame.size.width / 2.0;
    
    [self.avatar1.layer setMasksToBounds:YES];
    [self.avatar2.layer setMasksToBounds:YES];
    [self.avatar3.layer setMasksToBounds:YES];
    
//    [self.favButton setImage:[UIImage imageNamed:@"fav_enable"] forState:UIControlStateNormal];
//    [self.favButton setImage:[UIImage imageNamed:@"fav_disble"] forState:UIControlStateSelected];
    
    [self.favButton setAlpha:0.5];
//    [self.favStarImage setAlpha:1];
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)favoritesAction:(UIButton *)sender {
    if (sender.isSelected == 0) {
//      [self.favButton setImage:[UIImage imageNamed:@"fav_enable"] forState:UIControlStateNormal];
        
        [self.favStarImage setImage:[UIImage imageNamed:@"star_green_fill"]];
        self.favStarImage.alpha = 1;
        sender.selected = 1;
        sender.alpha = 1;
    } else {
//        [self.favButton setImage:[UIImage imageNamed:@"fav_disable"] forState:UIControlStateNormal];
        [self.favStarImage setImage:[UIImage imageNamed:@"star_white_out"]];
        self.favStarImage.alpha = 0.5;
        sender.selected = 0;
        sender.alpha = 0.5;
    }
    
    NSDictionary *parameters = [[NSDictionary alloc] init];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    parameters = @{@"id_flat": self.flat_ID, @"id_user": [ud objectForKey:@"user_id"]};
    
    ServerRequest *request = [ServerRequest initRequest:ServerRequestTypePOST With:parameters To:@"flats/favourites"];
    Server *server = [Server new];
    [server sentToServer:request OnSuccess:^(NSDictionary *result) {
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"ID = %@",
                             self.flat_ID];
        
        RLMResults<FavouriteFlats*> *flats = [FavouriteFlats objectsWithPredicate:pred];
        
        if([flats.firstObject.ID isEqualToString:self.flat_ID])
        {
            [realm beginWriteTransaction];
            [realm deleteObject:flats.firstObject];
            [realm commitWriteTransaction];
        }
        else
        {
            FavouriteFlats *favoutiteFlat = [FavouriteFlats new];
            favoutiteFlat.ID = self.flat_ID;
            [realm beginWriteTransaction];
            [realm addObject:favoutiteFlat];
            [realm commitWriteTransaction];
        }
        
    }  OrFailure:^(NSError *error) {
        NSLog(@"Error favourite request");
    }];
}

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

@end
