//
//  ViewController.m
//  TextSample
//
//  Created by 大久保直昭 on 2015/07/16.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *labelTextField;
@property (weak, nonatomic) IBOutlet UILabel *labelTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_textField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self textFieldDidChange];
    [self textViewDidChange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self textViewDidChange];
}

- (void)textFieldDidChange
{
    _labelTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_textField.text length]];
    [_labelTextField sizeToFit];
}

- (void)textViewDidChange
{
    _labelTextView.text = [NSString stringWithFormat:@"%lu", [_textView.text length]];
    [_labelTextView sizeToFit];
}

@end
