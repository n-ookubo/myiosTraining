//
//  ViewController.m
//  CustomContainerSample
//
//  Created by 大久保直昭 on 2015/07/08.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *frameView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.firstView = [self.storyboard instantiateViewControllerWithIdentifier:@"firstView"];
    self.secondView = [self.storyboard instantiateViewControllerWithIdentifier:@"secondView"];
    self.thirdView = [self.storyboard instantiateViewControllerWithIdentifier:@"thirdView"];
    
    [self changeCurrentView:self.firstView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeCurrentView:(UIViewController *)nextView
{
    UIViewController *current = self.currentView;
    
    if (!current) {
        [self addChildViewController:nextView];
        nextView.view.frame = self.frameView.frame;
        [self.view addSubview:nextView.view];
        [nextView didMoveToParentViewController:self];
        self.currentView = nextView;
        return;
    }
    
    [current willMoveToParentViewController:nil];
    [self addChildViewController:nextView];
    
    CGFloat nextWidth = nextView.view.bounds.size.width;
    CGFloat nextHeight = nextView.view.bounds.size.height;
    nextView.view.frame = CGRectMake(0, -nextHeight, nextWidth, nextHeight);
    
    [self transitionFromViewController:current toViewController:nextView duration:0.4f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        nextView.view.frame = self.frameView.frame;
    }completion:^(BOOL finished){
        [current removeFromParentViewController];
        [nextView didMoveToParentViewController:self];
    }];
    
    self.currentView = nextView;
}

- (IBAction)DidSegmentChange:(id)sender {
    switch(self.segment.selectedSegmentIndex){
        case 0:
            [self changeCurrentView:self.firstView];
            break;
        case 1:
            [self changeCurrentView:self.secondView];
            break;
        case 2:
            [self changeCurrentView:self.thirdView];
            break;
    }
}

@end
