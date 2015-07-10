//
//  ViewController.m
//  UIViewSample
//
//  Created by 大久保直昭 on 2015/07/10.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIView *myContainerView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 192, 40)];
    label.text = @"MyLabel";
    [view addSubview:label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(8, 56, 192, 30)];
    [button setTitle:@"Remove Image" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTouchUpButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(8, 94, 192, 40)];
    field.backgroundColor = [UIColor whiteColor];
    field.text = @"MyTextField";
    [view addSubview:field];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ojisan"]];
    image.frame = CGRectMake(8, 142, 200, 200);
    image.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:image];
    
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(8, 350, 360, 192)];
    text.backgroundColor = [UIColor whiteColor];
    text.text = @"UIViewクラスは大きく分けて以下の役割を持っています。\n・独自のコンテンツ描画（画面上に表示するオブジェクトとしての役割）\n・各Viewを管理するコンテナ\n・アニメーション\n・イベント処理（タップやピンチインなど）\n画面上に表示するもの自身としての役割と、階層構造でUIViewを管理している、という点をまず押さえてください。以下ではUIViewの利用方法と仕組みについて説明します。";
    [view addSubview:text];
    
    myContainerView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTouchUpButton
{
    for(UIView *view in myContainerView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]){
            [view removeFromSuperview];
        }
    }
}

@end
