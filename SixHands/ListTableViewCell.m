//
//  ListTableViewCell.m
//  SixHands
//
//  Created by Anton Scherbakov on 07/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.hands.layer.cornerRadius = 15.f;
    self.hands.layer.borderColor = [UIColor grayColor].CGColor;
    self.hands.layer.borderWidth = 0.5f;
    
    self.avatar1.layer.cornerRadius = self.avatar1.frame.size.width / 2.0;
    self.avatar2.layer.cornerRadius = self.avatar2.frame.size.width / 2.0;
    self.avatar3.layer.cornerRadius = self.avatar3.frame.size.width / 2.0;
    
    [self.avatar1.layer setMasksToBounds:YES];
    [self.avatar2.layer setMasksToBounds:YES];
    [self.avatar3.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
