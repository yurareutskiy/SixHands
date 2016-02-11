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

@implementation PhoneViewController {
    NSString *codeText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.phoneField.formatter setDefaultOutputPattern:@"(###) ###-##-##"];
    self.phoneField.formatter.prefix = @"+7 ";
    
    self.code.delegate = self;
    self.notCode.delegate = self;
    self.phoneField.delegate = self;
    
    for (UITextField *codeItem in self.codeLabels) {
        codeItem.delegate = self;
        codeItem.keyboardType = UIKeyboardTypePhonePad;
        codeItem.returnKeyType = UIReturnKeyDone;
        codeItem.autocorrectionType = UITextAutocorrectionTypeNo;
        
        if (codeItem.tag == 104) {
            


        }


    }
    
    UIBarButtonItem *barButtonCode = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(checkCode)];
    UIToolbar *toolbarCode = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbarCode.items = [NSArray arrayWithObject:barButtonCode];
    
    _plsCode.hidden = YES;
    _notCode.hidden = YES;
    _code.hidden = YES;
    
    self.phoneField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneField.returnKeyType = UIReturnKeyNext;
    self.phoneField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    UIBarButtonItem *barButtonPhone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sendSMS)];
    UIToolbar *toolbarPhone = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbarPhone.items = [NSArray arrayWithObject:barButtonPhone];
    self.phoneField.inputAccessoryView = toolbarPhone;
    
//    self.code.keyboardType = UIKeyboardTypePhonePad;
//    self.code.returnKeyType = UIReturnKeyDone;
//    self.code.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    // Do any additional setup after loading the view.
}

- (void)sendSMS {
    if ([self.phoneField.text length] == 18) {
        for (UITextField *codeItem in self.codeLabels) {
            codeItem.hidden = NO;
            if (codeItem.tag == 101) {
                [codeItem becomeFirstResponder];
            }
        }
        self.view1.hidden = YES;
        self.plsInput.hidden = YES;
        self.phoneField.hidden = YES;
        
        self.backButton.hidden = NO;
        self.notCode.hidden = NO;
        self.plsCode.hidden = NO;
    }
}

- (void)checkCode {
    NSLog(@"%@", codeText);
    if ([codeText isEqualToString:@"1234"]) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self presentViewController:vc animated:true completion:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    
    if (textField.tag == 1) {

        _view1.hidden = YES;
        _plsInput.hidden = YES;
        _phoneField.hidden = YES;
    
        _plsCode.hidden = NO;
        _notCode.hidden = NO;
        _code.hidden = NO;
        
        [self.phoneField resignFirstResponder];
    }
    if (textField.tag == 0) {
        
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self presentViewController:vc animated:true completion:nil];
        
        [self.code resignFirstResponder];
        
    }
    return YES;
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
    NSLog(@"string - %@", string);
    if (range.length == 1 && textField.tag > 100) {
        textField.text = @"";
        for (UITextField *tf in self.codeLabels) {
            if (tf.tag == (textField.tag - 1)) {
                [tf becomeFirstResponder];
                return NO;
            }
        }
        return NO;
    }
    if ([self.codeLabels containsObject:textField]) {
        
        textField.text = string;
        NSMutableDictionary *codeTagDictionary = [[NSMutableDictionary alloc] init];
        for (UITextField *codeItem in self.codeLabels) {
            [codeTagDictionary setObject:codeItem forKey:[NSString stringWithFormat:@"%d", codeItem.tag]];
        }
        if (textField.tag == 104) {
            codeText = [NSString stringWithFormat:@"%@%@%@%@", ((UITextField*)codeTagDictionary[@"101"]).text, ((UITextField*)codeTagDictionary[@"102"]).text, ((UITextField*)codeTagDictionary[@"103"]).text, string];
            [self.view endEditing:YES];
            [self checkCode];
        } else {
            int destinationTag = textField.tag + 1;
            UITextField *destinationField = codeTagDictionary[[NSString stringWithFormat:@"%d", destinationTag]];
            [destinationField becomeFirstResponder];
        }
        return NO;
    }
    
    if (textField.tag == 0 && range.location == 5) {
        textField.text = [NSString stringWithFormat:@"%@ %@", textField.text, string];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [textField resignFirstResponder];
            [self checkCode];
        });
        return NO;
    }
    
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
//    [self.phoneField resignFirstResponder];
//    [self.code resignFirstResponder];
    [self.view endEditing:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (IBAction)backButtonAction:(UIButton *)sender {
//    if ([self.code.text length] == 0) {
//        [self.code resignFirstResponder];
//        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
//        [self presentViewController:vc animated:true completion:nil];
//    }
    [self.phoneField becomeFirstResponder];
    self.view1.hidden = NO;
    self.plsInput.hidden = NO;
    self.phoneField.hidden = NO;
    
    self.code.hidden = YES;
    self.backButton.hidden = YES;
    self.notCode.hidden = YES;
    self.plsCode.hidden = YES;
    for (UITextField *tf in self.codeLabels) {
        tf.text = @"";
        tf.hidden = YES;
    }
}
@end
