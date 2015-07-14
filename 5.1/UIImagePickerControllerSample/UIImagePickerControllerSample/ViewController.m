//
//  ViewController.m
//  UIImagePickerControllerSample
//
//  Created by 大久保直昭 on 2015/07/13.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(choosePhoto)];
    self.navigationItem.rightBarButtonItem = item;
    
    _scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scroll.backgroundColor = [UIColor lightGrayColor];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(0, 0);
    _image = [[UIImageView alloc] init];
    [_scroll addSubview: _image];
    
    _scroll.maximumZoomScale = 3.0;
    _scroll.maximumZoomScale = 1.0;
    
    [self.view addSubview:_scroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [_scroll setFrame:CGRectMake(0, 0, size.width, size.height)];
        [self setZoomScale];
        [self centeringImage];
    } completion:nil];
}

- (void)setZoomScale
{
    UIImage *img = _image.image;
    if (!img) {
        return;
    }
    
    CGSize size = _scroll.bounds.size;
    CGFloat barHeight = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat rateX = size.width / img.size.width;
    CGFloat rateY = (size.height - barHeight) / img.size.height;
    _scroll.maximumZoomScale = 3.0;
    _scroll.minimumZoomScale = rateX > rateY ? rateY : rateX;
    
    if (_scroll.zoomScale < _scroll.minimumZoomScale) {
        _scroll.zoomScale = _scroll.minimumZoomScale;
    }
}

- (void)centeringImage
{
    CGRect rect = _image.frame;
    CGRect bounds = _scroll.bounds;
    CGFloat barHeight = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    rect.origin = CGPointZero;
    if (CGRectGetWidth(rect) <= CGRectGetWidth(bounds))
    {
        rect.origin.x = floor((CGRectGetWidth(bounds) - CGRectGetWidth(rect)) * 0.5);
    }
    
    CGFloat clientHeight = CGRectGetHeight(bounds) - barHeight;
    if (CGRectGetHeight(rect) < clientHeight)
    {
        rect.origin.y = floor((clientHeight - CGRectGetHeight(rect)) * 0.5);
    }
    _image.frame = rect;
}

- (void)choosePhoto
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //controller.allowsEditing = YES;
    
    controller.delegate = self;
    [self.view.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    CGRect imgRect = CGRectMake(0, 0, img.size.width, img.size.height);
    // reset zoomscale
    _scroll.zoomScale = 1;
    // set new size
    [_image setImage:img];
    [_image setFrame:imgRect];
    [_scroll setContentSize:imgRect.size];
    
    [self setZoomScale];
    _scroll.zoomScale = _scroll.minimumZoomScale;
    [self centeringImage];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _image;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centeringImage];
}

@end
