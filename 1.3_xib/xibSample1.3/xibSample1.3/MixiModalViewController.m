//
//  MixiModalViewController.m
//  xibSample1.3
//
//  Created by n_ookubo on 2015/07/06.
//  Copyright (c) 2015年 n_ookubo. All rights reserved.
//

#import "MixiModalViewController.h"

@interface MixiModalViewController ()

@end

@implementation MixiModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.slider setValue:0.5f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSliderValue:(float)value {
    [self.slider setValue:value];
    [self sliderChanged:nil];
}
- (IBAction)sliderChanged:(id)sender {
    float val = self.slider.value;
    UIColor *color = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:val];
    self.colorView.backgroundColor = color;
}
- (IBAction)didTouchButton:(id)sender {
    if ([_delegate respondsToSelector:@selector(setSliderValue:)]) {
        [_delegate setSliderValue:self.slider.value];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    /*
    if ([_delegate respondsToSelector:@selector(didPressCloseButton)]) {
        [_delegate didPressCloseButton];
    }
     */
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
