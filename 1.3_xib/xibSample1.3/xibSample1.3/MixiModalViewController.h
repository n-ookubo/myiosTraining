//
//  MixiModalViewController.h
//  xibSample1.3
//
//  Created by n_ookubo on 2015/07/06.
//  Copyright (c) 2015年 n_ookubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MixiModalViewControllerDelegate <NSObject>
-(void)didPressCloseButton;
@end

@interface MixiModalViewController : UIViewController
@property(nonatomic, weak) id<MixiModalViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

-(void)setSliderValue:(float)value;
@end
