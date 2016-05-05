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
@property (strong, nonatomic) NSArray *parameters;
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

    
    self.parameters = @[@"Жилая площадь, м²", @"Кухня, м²",@"Высота потолков, м",@"Этаж",@"Этажей в доме",@"Балконов",@"Лоджий",@"Раздельных санузлов",@"Совмещенных санузлов",@"Вид из окон",@"Тип ремонта",@"Тип дома",@"Название жк",@"Год постройки",@"Пассажирских лифтов",@"Грузовых лифтов",@"Наличие мусоропровода",@"Наличие телефона"];
    descriptionRow = ([self.parameters count]+2);
}

- (void)fotTest {
    self.address = @"Москва, ул. Верхняя Масловка, 21";
    descriptionText = @"Сдам 2-х. ком.квартиру., Москва, ул. Верхняя Масловка, 21, 5/7 эт.кирп.дома. Общ.пл.60 кв.м.,по комнатам 20/14 кв.м., кухня 12 кв.м.,СУР., для проживание все есть кроме телевизора., холодильник,посудомоечная машина., кровать, шкаф, гарнитур на кухне., в хорошем состоянии. Квартира в историческом центре Москвы, сталинский дом, высокие потолки 3 м, ж.б. перекрытия, в шаговой доступности Петровский парк, до метро Динамо 8 минут пешком.Развитая инфраструктура. Цена 65 т.р.+ счетчики+свет+депозит+50%, только славяне !";
    
    
    if ([self.navigationItem.title length] == 0) {
        self.navigationItem.title = @"Нежинская улица, дом 9";
    }
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 0)];
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
        return 250.f;
    } else if (indexPath.row == 1) {
        return 200;
    } else if (indexPath.row == descriptionRow) {
        return [self labelHehghtForText:descriptionText];
    }
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.parameters count]+3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        NSString *CellIdentifier = @"ScrollCell";
        cell = (ScrollFlatTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        float width = self.view.frame.size.width;
        [(ScrollFlatTableViewCell*)cell setScrollViewWithWidth:width];
    } else if (indexPath.row == 1) {
        NSString *CellIdentifier = @"GeneralDescriptionCell";
        cell = (GeneralDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }else if ((indexPath.row >1)&&(indexPath.row < descriptionRow)){
        NSString *CellIdentifier = @"InfoCell";
        cell = (InfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ((InfoTableViewCell*)cell).nameLabel.text = self.parameters[indexPath.row-2];
    }else if (indexPath.row == descriptionRow) {
        NSString *CellIdentifier = @"DescriptionCell";
        cell = (DescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        ((DescriptionTableViewCell*)cell).descriptionLabel.text = @"Описание";
        ((DescriptionTableViewCell*)cell).titleText.text = descriptionText;
        
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


