//
//  SecondScrollViewController.m
//  SixHands
//
//  Created by Reutskiy Jury on 2/13/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "SecondScrollViewController.h"
#import "ParameterTableViewCell.h"

@interface SecondScrollViewController ()
@property (strong, nonatomic) NSArray *parameters;

@end

@implementation SecondScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0.0,0.0, self.view.frame.size.width, self.view.frame.size.height-50);
    CGRect rect = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    self.scroll.frame = rect;
    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, 986.0);
    self.scroll.contentInset = UIEdgeInsetsMake(0.0, 0.0, 452.0, 0.0);
    self.table.scrollEnabled = NO;

    
    self.parameters = @[@"  Жилая площадь, м²", @"  Кухня, м²",@"  Высота потолков, м",@"  Этаж",@"  Этажей в доме",@"  Балконов",@"  Лоджий",@"  Раздельных санузлов",@"  Совмещенных санузлов",@"  Вид из окон",@"  Тип ремонта",@"  Тип дома",@"  Название жк",@"  Год постройки",@"  Пассажирских лифтов",@"  Грузовых лифтов",@"  Наличие мусоропровода",@"  Наличие телефона"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableTapped:event:)];
//    tapRecognizer.numberOfTouchesRequired = 1;
//    [self.table addGestureRecognizer:tapRecognizer];
//    self.slider.popUpViewColor = [UIColor clearColor];
//    self.slider.textColor = [UIColor blackColor];
//    self.slider.font = [UIFont fontWithName:@"Lato-Regular" size:12];
//    self.slider.popUpViewArrowLength = 2;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 150;
    self.sliderLabel.text = @"0 м";
//    self.slider.
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
 
}

-(void)viewWillAppear:(BOOL)animated {

   // self.scroll.contentInset = UIEdgeInsetsMake(0.0, 0.0, 452.0, 0.0);
}

- (void)viewDidAppear:(BOOL)animated {

    CGRect tableRect = CGRectMake(0, 194, self.view.frame.size.width, 792.0);
    NSLog(@"Rect %@", NSStringFromCGRect(tableRect));
    
    self.table.frame = tableRect;

    NSLog(@"Table rect %@", NSStringFromCGRect(self.table.frame));
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
    self.sliderLabel.text = [NSString stringWithFormat:@"%d м", (int)sender.value];
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.parameters count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"parameter"];

    if (!cell) {
        cell = [[ParameterTableViewCell alloc] init];
    }
    cell.keyLabel.text = self.parameters[indexPath.row];
    cell.valueTextField.tag = indexPath.row;
    cell.valueTextField.delegate = self;
//    NSLog(@"INDEX = %ld",(long)indexPath.row);
//    [cell.valueTextField addTarget:self action:@selector(checkTextFieldTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

//- (void) tableTapped:(id) sender event:(id) event{
//    UITapGestureRecognizer *rec = (UITapGestureRecognizer*)sender;
//    CGPoint tapPoint = [rec locationInView:self.table];
//    NSIndexPath *path = [self.table indexPathForRowAtPoint:tapPoint];
//    NSLog(@"index = %@",path);
//}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
    NSLog(@"Расположение2 = %ld",(long)activeField.tag);
}

 - (void)keyboardWasShown:(NSNotification*)aNotification // Обработка сообщения о отображении клавиатуры
{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size; // получаем размер клавиатуры
    //self.scroll.contentSize = CGSizeMake(self.view.frame.size.width,986.0+kbSize.height);
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    self.scroll.contentInset = contentInsets;
//    self.scroll.scrollIndicatorInsets = contentInsets;
//    NSLog(@"КЛАВА = %f",kbSize.height);
//    kbSize.height -=50;
//    NSLog(@"КЛАВА без = %f",kbSize.height);
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
//// Вызывается при окончании редактирования текстового поля, метод делегата
//-(void)textFieldDidEndEditing:(UITextField *)textField {
//    activeField = nil;
//}
//
//// Вызывается при нажатии Enter на клавиатуре
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//// При освобождении из памяти, снимаем контроллер вида с центра уведомлений
//- (void) dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


@end
