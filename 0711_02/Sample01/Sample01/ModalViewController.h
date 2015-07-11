//
//  ModalViewController.h
//  Sample01
//
//  Created by 大久保直昭 on 2015/07/11.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalViewControllerDelegate <NSObject>
- (void)closeView:(id)sender;

@end

@interface ModalViewController : UIViewController<ModalViewControllerDelegate>
@property (atomic) int showValue;
@property (weak, nonatomic) id<ModalViewControllerDelegate> delegate;
@end
