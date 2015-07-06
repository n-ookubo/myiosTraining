//
//  MixiSampleViewController.m
//  xibSample1.3
//
//  Created by n_ookubo on 2015/07/06.
//  Copyright (c) 2015年 n_ookubo. All rights reserved.
//

#import "MixiSampleViewController.h"

@interface MixiSampleViewController ()
{
    MixiModalViewController *modal;
}
@end

@implementation MixiSampleViewController
- (void)loadView{
    [super loadView];
    
    modal = [[MixiModalViewController alloc] init];
    modal.delegate = self;
    
    [self.slider setValue:0.6];
    [self changeSlider:nil];
    [self switchToggled:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSliderValue:(float)value {
    [self.slider setValue:value];
    [self changeSlider:nil];
}
- (IBAction)changeSlider:(id)sender {
    float val = self.slider.value;
    [self.grayView setBackgroundColor:[UIColor colorWithRed:val green:val blue:val alpha:1.0f]];
    self.label.text = [NSString stringWithFormat:@"%.2f", val];
}
- (IBAction)switchToggled:(id)sender {
    UIColor *color = self.mySwitch.on ? [UIColor colorWithRed:0.2f green:0.4f blue:0.4f alpha:1.0f]:[UIColor whiteColor];
    //[self.blueView setBackgroundColor:color];
    [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        self.blueView.backgroundColor = color;
    } completion:^(BOOL finished){}];
}
- (IBAction)touchButton:(id)sender {
    [modal setSliderValue:self.slider.value];
    //[self presentViewController:modal animated:YES completion:nil];
    [self.view.window.rootViewController presentViewController:modal animated:YES completion:nil];
}
-(void)didPressCloseButton
{
    [self setSliderValue:modal.slider.value];
    //[self dismissViewControllerAnimated:YES completion:nil];
    [modal dismissViewControllerAnimated:YES completion:nil];
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
