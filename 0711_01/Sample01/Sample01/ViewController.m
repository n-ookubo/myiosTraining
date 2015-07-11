//
//  ViewController.m
//  Sample01
//
//  Created by 大久保直昭 on 2015/07/11.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "ViewController.h"
#import "CountViewController.h"

@interface ViewController ()
@property (strong, nonatomic) CountViewController *controller;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"CountViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didStartButtonTouchUp:(id)sender {
    self.controller.countValue = 1;
    [self.navigationController pushViewController:self.controller animated:YES];
}
- (IBAction)didContinueButtonTouchUp:(id)sender {
    [self.navigationController pushViewController:self.controller animated:YES];
}



@end
