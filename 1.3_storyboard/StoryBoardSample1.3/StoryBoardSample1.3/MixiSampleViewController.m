//
//  MixiSampleViewController.m
//  StoryBoardSample1.3
//
//  Created by n_ookubo on 2015/07/06.
//  Copyright (c) 2015年 n_ookubo. All rights reserved.
//

#import "MixiSampleViewController.h"

@interface MixiSampleViewController ()

@end

@implementation MixiSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.label.text = @"Test";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchButton:(id)sender {
    self.label.text = @"YES";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
