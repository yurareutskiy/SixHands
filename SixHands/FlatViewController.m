//
//  FlatViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 03/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "FlatViewController.h"
#import "ScrollFlatTableViewCell.h"
#import "GeneralDescriptionTableViewCell.h"
#import "InfoTableViewCell.h"
#import "DescriptionTableViewCell.h"
#import "ChatViewController.h"

@interface FlatViewController ()

@end

@implementation FlatViewController {
    NSString *descriptionText;
    NSInteger descriptionRow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fotTest];
    
    self.cofirmButton.backgroundColor = [UIColor colorWithRed:79.0/238.0 green:197.0/255.0 blue:183.0/255.0 alpha:1.0];

    self.table.delegate = self;
    self.table.dataSource = self;

    [self.table registerClass:[DescriptionTableViewCell class] forCellReuseIdentifier:@"DescriptionCell"];
}

- (void)fotTest {
    self.address = @"Москва, ул. Верхняя Масловка, 21";
    descriptionText = @"Сдам 2-х. ком.квартиру., Москва, ул. Верхняя Масловка, 21, 5/7 эт.кирп.дома. Общ.пл.60 кв.м.,по комнатам 20/14 кв.м., кухня 12 кв.м.,СУР., для проживание все есть кроме телевизора., холодильник,посудомоечная машина., кровать, шкаф, гарнитур на кухне., в хорошем состоянии. Квартира в историческом центре Москвы, сталинский дом, высокие потолки 3 м, ж.б. перекрытия, в шаговой доступности Петровский парк, до метро Динамо 8 минут пешком.Развитая инфраструктура. Цена 65 т.р.+ счетчики+свет+депозит+50%, только славяне !";
    descriptionRow = 14;
    
}

-(void)viewWillAppear:(BOOL)animated {

}

-(void)viewDidAppear:(BOOL)animated {
    self.capView.hidden = YES;

    [UIView animateWithDuration:0.3 animations:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float)labelHehghtForText:(NSString*)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 0)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    label.attributedText = attributedString;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
//    label.text = text;
    label.font = [UIFont fontWithName:@"Lato-Regular" size:14.f];
    [label sizeToFit];
    float textHeight = label.frame.size.height;
    return textHeight + 75;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200.f;
    } else if (indexPath.row == 1) {
        return 183;
    } else if (indexPath.row == descriptionRow) {
        return [self labelHehghtForText:descriptionText];
    }
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        NSString *CellIdentifier = @"ScrollCell";
        cell = (ScrollFlatTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        float width = self.view.frame.size.width;
        [(ScrollFlatTableViewCell*)cell setScrollViewWithWidth:width];
    } else if (indexPath.row == 1) {
        NSString *CellIdentifier = @"GeneralDescriptionCell";
        cell = (GeneralDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    } else if (indexPath.row == descriptionRow) {
        NSString *CellIdentifier = @"InfoCell";
        cell = (InfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
//        ((InfoTableViewCell*)cell).descriptionTextLabel.text = descriptionText;
        [(InfoTableViewCell*)cell setDescriptionText:descriptionText];
        ((InfoTableViewCell*)cell).valueLabel.hidden = YES;
        ((InfoTableViewCell*)cell).descriptionTextLabel.hidden = NO;
        NSLog(@"%f, %f", ((InfoTableViewCell*)cell).descriptionTextLabel.frame.origin.x, ((InfoTableViewCell*)cell).descriptionTextLabel.frame.origin.y);

    } else {
        NSString *CellIdentifier = @"InfoCell";
        cell = (InfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

    }

    return cell;

}




- (IBAction)makeChatAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"makeChat" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"makeChat"]) {
        ChatViewController *vc = segue.destinationViewController;
        vc.navigationItem.title = self.address;
    }
}


@end


