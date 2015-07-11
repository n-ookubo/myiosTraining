//
//  CountViewController.m
//  Sample01
//
//  Created by 大久保直昭 on 2015/07/11.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "CountViewController.h"

@interface CountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation CountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _countValue = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLabel:_countValue];
}

- (void)setLabel:(int)count
{
    [_myLabel setText:[NSString stringWithFormat:@"%d", count]];
}

- (IBAction)didButtonTouchUp:(id)sender {
    [self setLabel:++_countValue];
    
    if (!(_countValue % 10)) {
        ModalViewController *modal = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
        modal.delegate = self;
        modal.showValue = _countValue;
        [self.view.window.rootViewController presentViewController:modal animated:YES completion:nil];
    }
}

- (void)closeView:(id)sender
{
    [sender dismissViewControllerAnimated:YES completion:nil];
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
