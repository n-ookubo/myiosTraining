//
//  MixiViewController.h
//  NavigationSample
//
//  Created by n_ookubo on 2015/07/07.
//  Copyright (c) 2015年 n_ookubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MixiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (atomic) int depth;
@property (strong, nonatomic) NSString *message;
@end
