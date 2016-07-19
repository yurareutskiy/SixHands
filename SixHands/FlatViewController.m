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
#import "Params.h"
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
    NSString *jsonString = _flat.parameters;
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSMutableArray *mutableArray = [NSMutableArray new];
    NSMutableArray *paramsNamesArray = [NSMutableArray new];
    if(jsonString != nil)
    {
    dict = [NSPropertyListSerialization
                          propertyListWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                          options:kNilOptions
                          format:NULL
                          error:NULL];

    NSLog(@"DICTIONARY %@",dict);
       mutableArray  = [[NSMutableArray alloc]init];
        
        for (NSString *sub in dict)
        {
            NSLog(@"SUB = %@",sub);
            [mutableArray addObject:sub];
        }
        for (NSString *key in mutableArray)
        {
            NSLog(@"KEY = %@",key);
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"ID = %@",
                                 key];
            RLMResults<Params *> *paramsWithKey = [Params objectsWithPredicate:pred];
            for (Params *param in paramsWithKey)
            {
                if(![[param RULocale] isEqualToString:@"описание"] && ![[param RULocale] isEqualToString:@"цена"])
                [paramsNamesArray addObject:[param RULocale]];
            }
        }
        NSLog(@"Array is: %@",paramsNamesArray);
    }
    self.parameters = paramsNamesArray;
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
        return 240.f;
    } else if (indexPath.row == 1) {
        return 200;
    } else if (indexPath.row == descriptionRow) {
        return 70;
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
    
    NSDictionary *dict1 = [NSPropertyListSerialization
                           propertyListWithData:[_flat.parameters dataUsingEncoding:NSUTF8StringEncoding]
                           options:kNilOptions
                           format:NULL
                           error:NULL];

    if (indexPath.row == 0) {
        NSString *CellIdentifier = @"ScrollCell";
        ScrollFlatTableViewCell* cell = (ScrollFlatTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[ScrollFlatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        float width = self.view.frame.size.width;
        cell.flat = self.flat;
        [(ScrollFlatTableViewCell*)cell setScrollViewWithWidth:width];
       
        NSLog(@"VLAD - %@",cell.flat.address);
        if(dict1[@"30"])
            ((ScrollFlatTableViewCell*)cell).priceLabel.text = [((ScrollFlatTableViewCell*)cell) formattedStringWithPrice:dict1[@"30"]];
        else
           ((ScrollFlatTableViewCell*)cell).priceLabel.text = @"No price";
        return cell;
    } else if (indexPath.row == 1) {
        NSString *CellIdentifier = @"GeneralDescriptionCell";
        cell = (GeneralDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];        if (cell==nil) {
            cell = [[GeneralDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
               }
        ((GeneralDescriptionTableViewCell*)cell).addressLabel.text = _flat.address;
        NSString *date = self.flat.createDate;
        NSArray* parsed = [date componentsSeparatedByString:@" "];
        ((GeneralDescriptionTableViewCell*)cell).postDate.text = parsed[0];
        ((GeneralDescriptionTableViewCell*)cell).postTime.text = parsed[1];
        NSLog(@"TIME - %@",parsed[1]);
    }else if ((indexPath.row >1)&&(indexPath.row < descriptionRow)){
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"RULocale = %@",
                             self.parameters[indexPath.row-2]];
        RLMResults<Params *> *paramsWithKey = [Params objectsWithPredicate:pred];
        NSMutableString *str = [NSMutableString new];
        for (Params *param in paramsWithKey)
        {
            [str appendString:param.ID];
        }
        NSString *CellIdentifier = @"InfoCell";
        cell = (InfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        ((InfoTableViewCell*)cell).nameLabel.text = self.parameters[indexPath.row-2];
        ((InfoTableViewCell*)cell).nameLabel.text =[((InfoTableViewCell*)cell).nameLabel.text stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[((InfoTableViewCell*)cell).nameLabel.text substringToIndex:1] uppercaseString]];
                NSLog(@"STR - %@",str);
//        NSLog(@"PAR = %@",dict1);
        ((InfoTableViewCell*)cell).valueLabel.text = [dict1 objectForKey:str];
//        NSLog(@"IDSTR = %@",str);
        
        
    }else if (indexPath.row == descriptionRow) {
        NSString *CellIdentifier = @"DescriptionCell";
        cell = (DescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        if(dict1[@"27"])
        {
        ((DescriptionTableViewCell*)cell).descriptionLabel.text = @"Описание";
        ((DescriptionTableViewCell*)cell).titleText.text = dict1[@"27"];
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


