//
//  ViewController.h
//  UserDefaultsSample
//
//  Created by 大久保直昭 on 2015/07/21.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ApplicationActivationDelegate <NSObject>
- (void)applicationActivation;

@end

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ApplicationActivationDelegate>


@end

