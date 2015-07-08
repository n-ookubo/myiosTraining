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
{
    NSInteger currentViewIndex;
}
@property (weak, nonatomic) IBOutlet UIView *frameView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.firstView = [self.storyboard instantiateViewControllerWithIdentifier:@"firstView"];
    self.secondView = [self.storyboard instantiateViewControllerWithIdentifier:@"secondView"];
    self.thirdView = [self.storyboard instantiateViewControllerWithIdentifier:@"thirdView"];
    
    currentViewIndex = -1;
    [self changeCurrentView:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [self getViewController:currentViewIndex].view.frame = self.frameView.frame;
}

- (void)changeCurrentView:(NSInteger)index
{
    UIViewController *current = [self getViewController:currentViewIndex];
    UIViewController *nextView = [self getViewController:index];
    
    if (!current) {
        [self addChildViewController:nextView];
        nextView.view.frame = self.frameView.frame;
        [self.view addSubview:nextView.view];
        [nextView didMoveToParentViewController:self];
        currentViewIndex = index;
        return;
    }
    
    if (currentViewIndex != index) {
        [current willMoveToParentViewController:nil];
        [self addChildViewController:nextView];
    }
    
    CGFloat nextWidth = self.frameView.bounds.size.width;
    CGFloat nextHeight = self.frameView.bounds.size.height;
    if (currentViewIndex > index) {
        nextView.view.frame = CGRectMake(-nextWidth, 0, nextWidth, nextHeight);
    } else if (currentViewIndex < index) {
        nextView.view.frame = CGRectMake(nextWidth, 0, nextWidth, nextHeight);
    }
    
    [self transitionFromViewController:current toViewController:nextView duration:0.4f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (currentViewIndex > index) {
            current.view.frame = CGRectMake(nextWidth, 0, nextWidth, nextHeight);
        } else if (currentViewIndex < index) {
            current.view.frame = CGRectMake(-nextWidth, 0, nextWidth, nextHeight);
        }
        nextView.view.frame = self.frameView.frame;
    }completion:^(BOOL finished){
        if (currentViewIndex != index) {
            [current removeFromParentViewController];
            [nextView didMoveToParentViewController:self];
        }
    }];
    
    currentViewIndex = index;
}

- (UIViewController *)getViewController:(NSInteger)index
{
    if (index < 0 || index > 2) {
        return nil;
    }
    NSArray *array = @[_firstView, _secondView, _thirdView];
    return [array objectAtIndex:index];
}

- (IBAction)DidSegmentChange:(id)sender {
    [self changeCurrentView:self.segment.selectedSegmentIndex];
}
- (IBAction)viewDidSwipeLeft:(UISwipeGestureRecognizer *)sender {
    NSInteger index = self.segment.selectedSegmentIndex;
    if (index < 2){
        [self changeCurrentView:(self.segment.selectedSegmentIndex = ++index)];
    }
}
- (IBAction)viewDidSwipeRIght:(UISwipeGestureRecognizer *)sender {
    NSInteger index = self.segment.selectedSegmentIndex;
    if (index > 0){
        [self changeCurrentView:(self.segment.selectedSegmentIndex = --index)];
    }
}
@end
