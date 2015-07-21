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
@property (strong, nonatomic) CountViewController *controller_;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"CountViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didStartButtonTouchUp:(id)sender {
    CountViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"CountViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)didContinueButtonTouchUp:(id)sender {
    CountViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"CountViewController"];
    int value = (int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"CountValue"] integerValue];
    controller.countValue = value;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)did10StartButtonTouchUp:(id)sender {
    CountViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"CountViewController"];
    controller.countValue = 10;
    [self.navigationController pushViewController:controller animated:YES];
}



@end
