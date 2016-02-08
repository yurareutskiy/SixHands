//
//  ChatTableViewCell.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/8/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.frame.size.height / 2;
    self.userImage.layer.masksToBounds = YES;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
