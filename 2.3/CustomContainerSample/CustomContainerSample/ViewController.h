//
//  ViewController.h
//  CustomContainerSample
//
//  Created by 大久保直昭 on 2015/07/08.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) UIViewController *firstView;
@property (strong, nonatomic) UIViewController *secondView;
@property (strong, nonatomic) UIViewController *thirdView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@end

