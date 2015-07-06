//
//  ViewController.m
//  xibSample1.3
//
//  Created by n_ookubo on 2015/07/06.
//  Copyright (c) 2015年 n_ookubo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)loadView
{
    // viewのロードとsubviewのロード、追加のみ
    [super loadView];
    
    self.mixiController = [[MixiSampleViewController alloc] initWithNibName:@"MixiSampleViewController" bundle:nil];
    [self.view addSubview:self.mixiController.view];
    
    CGRect selfFrame = self.view.frame;
    [self.mixiController.view setFrame:CGRectMake(selfFrame.origin.x, selfFrame.origin.y, selfFrame.size.width, selfFrame.size.height)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
