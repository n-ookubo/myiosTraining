//
//  ModalViewController.m
//  Sample01
//
//  Created by 大久保直昭 on 2015/07/11.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [_myLabel setText:[NSString stringWithFormat:@"%d", _showValue]];
}

- (IBAction)didCloseButtonTouchUp:(id)sender {
    if ([_delegate respondsToSelector:@selector(closeView:)]) {
        [_delegate closeView:self];
    }
}
- (IBAction)didMoreButtonTouchUp:(id)sender {
    ModalViewController *modal = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    modal.delegate = self;
    modal.showValue = _showValue;
    [self presentViewController:modal animated:YES completion:nil];
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
