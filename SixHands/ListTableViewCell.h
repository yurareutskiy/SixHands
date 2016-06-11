//
//  ListTableViewCell.h
//  SixHands
//
//  Created by Anton Scherbakov on 07/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubwayView.h"
#import "Flat.h"
@interface ListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIButton *hands;
@property (strong, nonatomic) IBOutlet UILabel *address;

@property (strong, nonatomic) IBOutlet UIImageView *avatar1;
@property (strong, nonatomic) IBOutlet UIImageView *avatar2;
@property (weak, nonatomic) IBOutlet UILabel *square;
@property (weak, nonatomic) IBOutlet UILabel *floor;
@property (weak, nonatomic) IBOutlet UILabel *rooms;
@property (weak, nonatomic) IBOutlet UILabel *timeToSub;
@property (strong, nonatomic) IBOutlet UIImageView *avatar3;
@property (weak, nonatomic) IBOutlet UILabel *moreFriendsLabel;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet SubwayView *subway;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIImageView *favStarImage;
@property (weak, nonatomic) IBOutlet UILabel *zeroFriends;
@property Flat* flat;

- (IBAction)favoritesAction:(UIButton *)sender;
- (NSString*)formattedStringWithPrice:(NSString*)price;

@end
