//
//  PhoneViewController.m
//  SixHands
//
//  Created by Anton Scherbakov on 07/02/16.
//  Copyright © 2016 Styleru. All rights reserved.
//

#import "PhoneViewController.h"

@interface PhoneViewController ()

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.phoneField.formatter setDefaultOutputPattern:@"# (###) ###-##-##"];
    self.phoneField.formatter.prefix = @"+";
    
    self.code.delegate = self;
    self.notCode.delegate = self;
    
    _plsCode.hidden = YES;
    _notCode.hidden = YES;
    _code.hidden = YES;
    _doneButton.hidden = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *code = [self formatCode:_code.text];
    int length1 = [self getLength:code];
    
    if(length1 == 1)
    {
        NSString *code = [self formatCode:_code.text];
        const char *c = [code UTF8String];
        _code.text = [NSString stringWithFormat:@"%c ",c[0]];
        
        if(range.length > 0)
            _code.text = [NSString stringWithFormat:@"%c",c[0]];
    }
    if(length1 == 2)
    {
        NSString *code = [self formatCode:_code.text];
        const char *c = [code UTF8String];
        _code.text = [NSString stringWithFormat:@"%c %c ",c[0],c[1]];
        
        if(range.length > 0)
            _code.text = [NSString stringWithFormat:@"%c %c",c[0],c[1]];
    }
    if(length1 == 3)
    {
        NSString *code = [self formatCode:_code.text];
        const char *c = [code UTF8String];
        _code.text = [NSString stringWithFormat:@"%c %c %c ",c[0],c[1],c[2]];
        
        if(range.length > 0)
            _code.text = [NSString stringWithFormat:@"%c %c %c",c[0],c[1],c[2]];
        
    }
    
    if(length1 == 4)
    {
        NSString *code = [self formatCode:_code.text];
        const char *c = [code UTF8String];
        _code.text = [NSString stringWithFormat:@"%c %c %c %c",c[0],c[1],c[2],c[3]];
        
        if(range.length == 0)
            return NO;
    }
    
    return YES;
}

-(NSString *)formatCode:(NSString *)code{
    code = [code stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return code;
}

-(int)getLength:(NSString*)code
{
    code = [code stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    int length = [code length];
    
    return length;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.phoneField resignFirstResponder];
    [self.code resignFirstResponder];
}

- (IBAction)nextButton:(UIButton *)sender {
    _view1.hidden = YES;
    _view2.hidden = YES;
    _nextButton.hidden = YES;
    _plsInput.hidden = YES;
    _phoneField.hidden = YES;
    
    _plsCode.hidden = NO;
    _notCode.hidden = NO;
    _code.hidden = NO;
    _doneButton.hidden = NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (IBAction)doneButton:(UIButton *)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self presentViewController:vc animated:true completion:nil];
}
@end
