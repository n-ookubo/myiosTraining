//
//  ViewController.m
//  NavigationSample
//
//  Created by n_ookubo on 2015/07/07.
//  Copyright (c) 2015年 n_ookubo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIViewController *mixiView = [self.storyboard instantiateViewControllerWithIdentifier:@"MixiViewController"];
    UINavigationController *navigationView = [[UINavigationController alloc] initWithRootViewController:mixiView];
    [self.view.window.rootViewController presentViewController:navigationView animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
