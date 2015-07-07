//
//  MixiViewController.m
//  NavigationSample
//
//  Created by n_ookubo on 2015/07/07.
//  Copyright (c) 2015年 n_ookubo. All rights reserved.
//

#import "MixiViewController.h"

@interface MixiViewController ()
{
    UIBarButtonItem *pushButton;
}
@end

@implementation MixiViewController

static NSArray *kBgColors;

+ (UIColor *)getBgColor:(int)index
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kBgColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor cyanColor], [UIColor magentaColor], [UIColor groupTableViewBackgroundColor]];
    });
    
    return kBgColors[index % kBgColors.count];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [self.class getBgColor:self.depth];
    self.title = [NSString stringWithFormat:@"%d", self.depth];
    self.myLabel.text = self.message;
    
    pushButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pressNavigationBarButton)];
    self.navigationItem.rightBarButtonItem = pushButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didButtonTap:(id)sender {
    [self pressPushButton:@"push by code"];
}

- (void) pressNavigationBarButton {
    [self pressPushButton:@"+++++"];
}

- (void) pressPushButton:(NSString *)message {
    MixiViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MixiViewController"];
    controller.depth = self.depth +1;
    controller.message = message;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [pushButton setEnabled:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [pushButton setEnabled:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [pushButton setEnabled:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [pushButton setEnabled:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    id dest = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"showSelfSegueA"]) {
        [dest setMessage:@"show A"];
        [dest setDepth:self.depth + 1];
    } else if([segue.identifier isEqualToString:@"showSelfSegueB"]) {
        [dest setMessage:@"show B"];
        [dest setDepth:self.depth + 1];
    }
}


@end
