//
//  InfoTableViewCell.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/10/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor colorWithRed:221.f/255.f green:222.f/255.f blue:226.f/255.f alpha:0.25];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDescriptionText:(NSString*)text {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.descriptionTextLabel.attributedText = attributedString;
//    self.descriptionTextLabel.text = text;

}

@end
