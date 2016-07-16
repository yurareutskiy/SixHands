//
//  SecondScrollViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "SecondScrollViewController.h"
#import "ParameterTableViewCell.h"
#import "Params.h"

@interface SecondScrollViewController ()

@property (strong, nonatomic) NSArray *parameters;
@property (strong, nonatomic) NSArray *parameters_type;

@property NSMutableDictionary *paramsDict;

@end

@implementation SecondScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0.0,0.0, self.view.frame.size.width, self.view.frame.size.height-50);
    CGRect rect = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    self.scroll.frame = rect;
//    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, 1206.0);
//    self.scroll.contentInset = UIEdgeInsetsMake(0.0, 0.0, 672.0, 0.0);
    self.table.scrollEnabled = NO;

    _paramsDict = [[NSMutableDictionary alloc] init];
    self.parameters_type = [[NSArray alloc]init];
    self.parameters = @[@"  Жилая площадь, м²", @"  Кухня, м²",@"  Высота потолков, м",@"  Этаж",@"  Этажей в доме",@"  Балконов",@"  Лоджий",@"  Раздельных санузлов",@"  Совмещенных санузлов",@"  Вид из окон",@"  Тип ремонта",@"  Тип дома",@"  Название жк",@"  Год постройки",@"  Пассажирских лифтов",@"  Грузовых лифтов",@"  Наличие мусоропровода",@"  Наличие телефона"];
    NSMutableArray *toFormParams = [NSMutableArray new];
    NSMutableArray *toFormParamstype = [NSMutableArray new];
    RLMResults<Params *> *dogs = [Params allObjects];
    for (NSInteger i = 0; i < [dogs count]; i++) {
        Params *param =  dogs[i];
        if (param.RULocale) {
            [toFormParams addObject:param.RULocale];
        }
        if (param.type) {
        [toFormParamstype addObject:param.type];
        }
    }
    self.parameters = toFormParams;
    self.parameters_type = toFormParamstype;
    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, 194+44.0*[self.parameters count]);
    self.scroll.contentInset = UIEdgeInsetsMake(0.0, 0.0, 12.0+44.0*([self.parameters count]-8), 0.0);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
//    self.
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 300;
    self.sliderLabel.text = @"0 м²";
//    self.slider.
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
 
}

-(void) saveParams
{
    [self.delegate addParams:_paramsDict];
    _flatToFill.square =[[NSString alloc] initWithFormat:@"%f",_slider.value];
    NSUserDefaults *ud = [[NSUserDefaults alloc] initWithSuiteName:@"flatToPost"];
    [ud setObject:[[NSString alloc] initWithFormat:@"%f",_slider.value] forKey:@"square"];
}

-(void)viewWillAppear:(BOOL)animated {

   // self.scroll.contentInset = UIEdgeInsetsMake(0.0, 0.0, 452.0, 0.0);
}

- (void)viewDidAppear:(BOOL)animated {

    CGRect tableRect = CGRectMake(0, 194, self.view.frame.size.width, 44.0*[self.parameters count]);
    
    self.table.frame = tableRect;

    NSArray *views = self.view.subviews;
    for (UIView *view in views) {
        NSLog(@"%@", view);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
//    self.scroll.contentOffset = CGPointMake(0.0, 432.0);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)roomNumberAction:(UIButton*)sender {
    BOOL wasSelected = sender.isSelected;
    for (UIButton *button in self.roomAmountButtons) {
        button.selected = NO;
    }
    if (!wasSelected) {
        sender.selected = YES;
    }
    
}
- (IBAction)sliderChangeValue:(UISlider *)sender {
    self.sliderLabel.text = [NSString stringWithFormat:@"%d м²", (int)sender.value];
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.parameters count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParameterTableViewCell *cell;
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!%@",self.parameters_type[indexPath.row]);
    if ([self.parameters_type[indexPath.row]  isEqual: @"varchar"]){
    ParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"string_parameter"];

//    if (!cell) {
//        cell = [[ParameterTableViewCell alloc] init];
//    }
    cell.keyLabel.text = self.parameters[indexPath.row];
    cell.keyLabel.text = [cell.keyLabel.text stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[cell.keyLabel.text substringToIndex:1] uppercaseString]];
    cell.valueTextField.tag = indexPath.row;
    Params *tmpParam = [[Params objectsWhere: [[NSString alloc] initWithFormat:@"RULocale = '%@'",self.parameters[indexPath.row]]] firstObject];
//


    cell.valueTextField.delegate = self;
    cell.valueTextField.ID = tmpParam.ID;
    NSLog(@"PARAM_ID===== %@",tmpParam.ID);
    NSLog(@"TFID - %@",self.parameters[indexPath.row]);
//    NSLog(@"INDEX = %ld",(long)indexPath.row);
//    [cell.valueTextField addTarget:self action:@selector(checkTextFieldTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    }
    if ([self.parameters_type[indexPath.row]  isEqual: @"numeric"]){
        ParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"int_parameter"];
        
        //    if (!cell) {
        //        cell = [[ParameterTableViewCell alloc] init];
        //    }
        cell.keyLabel.text = self.parameters[indexPath.row];
        cell.keyLabel.text = [cell.keyLabel.text stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[cell.keyLabel.text substringToIndex:1] uppercaseString]];
        cell.valueTextField.tag = indexPath.row;
        Params *tmpParam = [[Params objectsWhere: [[NSString alloc] initWithFormat:@"RULocale = '%@'",self.parameters[indexPath.row]]] firstObject];
        //
        
        
        cell.valueTextField.delegate = self;
        cell.valueTextField.ID = tmpParam.ID;
        NSLog(@"PARAM_ID===== %@",tmpParam.ID);
        NSLog(@"TFID - %@",self.parameters[indexPath.row]);
        //    NSLog(@"INDEX = %ld",(long)indexPath.row);
        //    [cell.valueTextField addTarget:self action:@selector(checkTextFieldTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    if ([self.parameters_type[indexPath.row]  isEqual: @"bool"]){
        ParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bool_parameter"];
        
        //    if (!cell) {
        //        cell = [[ParameterTableViewCell alloc] init];
        //    }
        cell.keyLabel.text = self.parameters[indexPath.row];
        cell.keyLabel.text = [cell.keyLabel.text stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[cell.keyLabel.text substringToIndex:1] uppercaseString]];
//        cell.valueTextField.tag = indexPath.row;
//        Params *tmpParam = [[Params objectsWhere: [[NSString alloc] initWithFormat:@"RULocale = '%@'",self.parameters[indexPath.row]]] firstObject];
//        //
//        
//        
//        cell.valueTextField.delegate = self;
//        cell.valueTextField.ID = tmpParam.ID;
//        NSLog(@"PARAM_ID===== %@",tmpParam.ID);
//        NSLog(@"TFID - %@",self.parameters[indexPath.row]);
        //    NSLog(@"INDEX = %ld",(long)indexPath.row);
        //    [cell.valueTextField addTarget:self action:@selector(checkTextFieldTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    if ([self.parameters_type[indexPath.row]  isEqual: @"optional"]){
        ParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"options_parameter"];
        
        //    if (!cell) {
        //        cell = [[ParameterTableViewCell alloc] init];
        //    }
        cell.keyLabel.text = self.parameters[indexPath.row];
        cell.keyLabel.text = [cell.keyLabel.text stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[cell.keyLabel.text substringToIndex:1] uppercaseString]];
        //        cell.valueTextField.tag = indexPath.row;
        //        Params *tmpParam = [[Params objectsWhere: [[NSString alloc] initWithFormat:@"RULocale = '%@'",self.parameters[indexPath.row]]] firstObject];
        //        //
        //
        //
        //        cell.valueTextField.delegate = self;
        //        cell.valueTextField.ID = tmpParam.ID;
        //        NSLog(@"PARAM_ID===== %@",tmpParam.ID);
        //        NSLog(@"TFID - %@",self.parameters[indexPath.row]);
        //    NSLog(@"INDEX = %ld",(long)indexPath.row);
        //    [cell.valueTextField addTarget:self action:@selector(checkTextFieldTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    return cell;
}


 - (void)keyboardWasShown:(NSNotification*)aNotification // Обработка сообщения о отображении клавиатуры
{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size; // получаем размер клавиатуры
    //self.scroll.contentSize = CGSizeMake(self.view.frame.size.width,986.0+kbSize.height);
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    self.scroll.contentInset = contentInsets;
//    self.scroll.scrollIndicatorInsets = contentInsets;
//    kbSize.height -=50;
//     Если активное поле ввода спрятано клавиатурой, скроллируем, чтобы показать его
//    CGRect aRect = self.scroll.frame;
//   aRect.size.height -= 114.0;
//    aRect.size.height -= kbSize.height;
//    aRect.size.height -= 244;
//    NSLog(@"ПОЛЕ = %f",aRect.size.height);
//    NSLog(@"Расположение = %ld",(long)activeField.tag);
    //CGRect rectfield = CGRectMake(0, 194.0, self.view.frame.size.width,88.0);
    //CGRect rectfield = CGRectMake(0,activeField.tag, self.view.frame.size.width,0.0);
//    CGRect rectfield = CGRectMake(0, 0, self.view.frame.size.width,0.0);
//    [self.scroll scrollRectToVisible:rectfield animated:YES];
//    CGPoint point = CGPointMake(0, 194+44*activeField.tag);
//    [self.scroll setContentOffset:point animated:YES];
 //  self.scroll.contentOffset = CGPointMake(0.0, 194.0+44.0*activeField.tag);
//    self.scroll.contentOffset = CGPointMake(0.0, 194.0+50.0*activeField.tag);
//    
//    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//        [self.scroll scrollRectToVisible:activeField.frame animated:YES];
//    }
 }

-(void)textFieldDidBeginEditing:(ParamsTextField *)textField {
    activeField = textField;
    NSLog(@"Расположение2 = %ld",(long)activeField.tag);
}

// Вызывается при окончании редактирования текстового поля, метод делегата
-(void)textFieldDidEndEditing:(ParamsTextField *)textField {
    [_paramsDict setValue:activeField.text forKey: [[NSString alloc] initWithFormat:@"%@",textField.ID]];
    activeField = nil;
    NSLog(@"DIC - %@",_paramsDict);
}

// Вызывается при нажатии Enter на клавиатуре
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
// При освобождении из памяти, снимаем контроллер вида с центра уведомлений
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
