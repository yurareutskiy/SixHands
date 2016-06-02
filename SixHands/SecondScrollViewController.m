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
    self.
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 300;
    self.sliderLabel.text = @"0 м";
//    self.slider.
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
 
}

-(void) saveParams
{
    _flatToFill.square =[[NSString alloc] initWithFormat:@"%f",_slider.value];
    NSUserDefaults *ud = [[NSUserDefaults alloc] initWithSuiteName:@"flatToPost"];
    [ud setObject:[[NSString alloc] initWithFormat:@"%f",_slider.value] forKey:@"square"];
}

-(void)viewWillAppear:(BOOL)animated {

}

- (void)viewDidAppear:(BOOL)animated {

    CGRect tableRect = CGRectMake(0, 194, self.view.frame.size.width, 792.0);
    
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"ENDED");
}

@end
