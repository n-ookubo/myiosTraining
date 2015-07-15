//
//  AssetRepresentationViewController.m
//  AssetsLibrarySample
//
//  Created by 大久保直昭 on 2015/07/15.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "AssetRepresentationViewController.h"

@interface AssetRepresentationViewController ()
{
    BOOL didZoomScaleInitialize;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation AssetRepresentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"representation";
    
    UIBarButtonItem *min = [[UIBarButtonItem alloc] initWithTitle:@"All" style:UIBarButtonItemStylePlain target:self action:@selector(showAllImage)];
    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithTitle:@"1x" style:UIBarButtonItemStylePlain target:self action:@selector(show1XImage)];
    self.navigationItem.rightBarButtonItems = @[min, one];
    
    // UIImageViewの作成とセット
    self.imageView = [[UIImageView alloc]initWithImage:_image];
    [_scrollView addSubview:_imageView];
    
    // スクロール対象サイズの設定
    CGFloat imgWidth = _image.size.width;
    CGFloat imgHeight = _image.size.height;
    CGRect imgRect = CGRectMake(0, 0, imgWidth, imgHeight);
    [_scrollView setContentSize:imgRect.size];
    
    didZoomScaleInitialize = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [self setZoomScale];
    [self centeringImage];
}

- (void)setZoomScale
{
    // UIScrollViewとスクロール対象サイズから、拡大倍率の最大値と最小値を求める
    CGSize clientSize = _scrollView.bounds.size;
    CGFloat barHeight = self.navigationController.navigationBar.frame.size.height
    + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat imgWidth = _image.size.width;
    CGFloat imgHeight = _image.size.height;
    CGFloat rateX = clientSize.width / imgWidth;
    CGFloat rateY = (clientSize.height - barHeight) / imgHeight;
    _scrollView.maximumZoomScale = 3.0;
    _scrollView.minimumZoomScale = MIN(MIN(rateX, rateY), 1.0);
    
    // 現在の拡大倍率が最小倍率未満なら修正
    // また初期化時は最小倍率にして表示する
    if (_scrollView.zoomScale < _scrollView.minimumZoomScale || !didZoomScaleInitialize) {
        _scrollView.zoomScale = _scrollView.minimumZoomScale;
        didZoomScaleInitialize = YES;
    }
}

- (void)centeringImage
{
    CGRect rect = _imageView.frame;
    CGRect bounds = _scrollView.bounds;
    CGFloat barHeight = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    rect.origin = CGPointZero;
    // widthがUIScrollViewの横幅より小さければセンタリングする
    if (CGRectGetWidth(rect) <= CGRectGetWidth(bounds))
    {
        rect.origin.x = floor((CGRectGetWidth(bounds) - CGRectGetWidth(rect)) * 0.5);
    }
    
    // heightがUIScrollViewの縦幅より小さければセンタリングする
    CGFloat clientHeight = CGRectGetHeight(bounds) - barHeight;
    if (CGRectGetHeight(rect) < clientHeight)
    {
        rect.origin.y = floor((clientHeight - CGRectGetHeight(rect)) * 0.5);
    }
    _imageView.frame = rect;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [_scrollView setFrame:CGRectMake(0, 0, size.width, size.height)];
        [self setZoomScale];
        [self centeringImage];
    } completion:nil];
 }
 */

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centeringImage];
}

- (void)showAllImage
{
    _scrollView.zoomScale = _scrollView.minimumZoomScale;
}
- (void)show1XImage
{
    _scrollView.zoomScale = 1.0;
}

@end
