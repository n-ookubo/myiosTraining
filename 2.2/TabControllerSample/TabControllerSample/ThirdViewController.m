//
//  ThirdViewController.m
//  TabControllerSample
//
//  Created by 大久保直昭 on 2015/07/08.
//
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.slider.value = 0.5f;
    [self didChangeSlider:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didChangeSlider:(id)sender {
    float val = 1.0f - self.slider.value * 0.5f;
    self.view.backgroundColor = [UIColor colorWithRed:val * 0.5f green:val * 0.75f blue:val alpha:1.0f];
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
