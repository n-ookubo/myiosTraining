//
//  ViewController.m
//  WebViewSample
//
//  Created by 大久保直昭 on 2015/07/21.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIBarButtonItem *backButton;
@property (strong, nonatomic) UIBarButtonItem *forwardButton;
@property (strong, nonatomic) UIBarButtonItem *requestButton;
@property (strong, nonatomic) UIBarButtonItem *refreshButton;
@property (strong, nonatomic) UIBarButtonItem *stopButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backButtonAction)];
    _forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forwardButtonAction)];
    _requestButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(requestButtonAction)];
    _refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonAction)];
    _stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopButtonAction)];
    self.navigationItem.leftBarButtonItems = @[_backButton, _forwardButton];
    self.navigationItem.rightBarButtonItems = @[_requestButton, _refreshButton];
    
    _backButton.enabled = NO;
    _forwardButton.enabled = NO;
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.33.10/hoge.php"]];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.rightBarButtonItems = @[_requestButton, _stopButton];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title.length == 0) {
        title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    }
    self.title = title;
    
    self.backButton.enabled = [self.webView canGoBack];
    self.forwardButton.enabled = [self.webView canGoForward];
    self.navigationItem.rightBarButtonItems = @[_requestButton, _refreshButton];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", error);
    self.navigationItem.rightBarButtonItems = @[_requestButton, _refreshButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == NSURLErrorCancelled) {
        return;
    }
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:[error.userInfo objectForKey:@"NSLocalizedDescription"] preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self.view.window.rootViewController presentViewController:controller animated:YES completion:nil];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", [request.URL description]);
    return YES;
}

- (void)backButtonAction
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)forwardButtonAction
{
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

- (void)requestButtonAction
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"URL" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *field = controller.textFields[0];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:field.text]];
        [self.webView loadRequest:request];
    }]];
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = [self.webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
        textField.placeholder = @"input URL";
    }];
    [self.view.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)refreshButtonAction
{
    [self.webView reload];
}

- (void)stopButtonAction
{
    if (self.webView.loading) {
        [self.webView stopLoading];
    }
}
@end
