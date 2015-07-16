//
//  ViewController.m
//  KeyboardNotificationSample_NoARC
//
//  Created by 大久保直昭 on 2015/07/16.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "HogeObject.h"

@interface ViewController ()@property (retain, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *push = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushController)];
    UIBarButtonItem *hide = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(hideKeyboard)];
    self.navigationItem.rightBarButtonItems = @[push, hide];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textView release];
    [super dealloc];
}

- (void)pushController
{
    ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)hideKeyboard
{
    [_textView resignFirstResponder];
}

- (void)resizeTextView:(CGRect)keyboardRect
{
    CGRect frame = self.view.frame;
    frame.size.height = keyboardRect.origin.y - frame.origin.y;
    [self.view setFrame:frame];
}

#pragma mark - keyboardNotification
- (void)keyboardWillShow:(NSNotification *)notification
{
    [self resizeTextView:[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]];
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    [self resizeTextView:[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]];
}
@end
