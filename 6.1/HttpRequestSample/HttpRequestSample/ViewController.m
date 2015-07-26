//
//  ViewController.m
//  HttpRequestSample
//
//  Created by 大久保直昭 on 2015/07/17.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField.text = @"http://192.168.33.10/hoge.php";
    self.textView.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)myLog:(NSString *)format, ...
{
    va_list args;
    va_start(args,format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    self.textView.text = [self.textView.text stringByAppendingString:[string stringByAppendingString:@"\n"]];
}

- (IBAction)didButtonTouch:(id)sender {
    self.button.enabled = NO;
    self.textView.text = @"";

    NSURL *url = [NSURL URLWithString:self.textField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    
    [self myLog:@"## sending request..."];
    [self myLog:@"  %@", [request description]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self receiveConnection:response data:data error:error];
        [session invalidateAndCancel];
    }];
    [task resume];
    [task cancel];
    /*
    NSOperationQueue *queue = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [self receiveConnection:response data:data error:connectionError];
    }];
    */
}

- (void) receiveConnection:(NSURLResponse *)response data:(NSData *)data error:(NSError *)connectionError {
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    if (connectionError) {
        [mainQueue addOperationWithBlock:^{
            [self myLog:@"\n## error!!!"];
            [self myLog:@"  %@", [connectionError description]];
            self.button.enabled = YES;
        }];
        return;
    }
    [mainQueue addOperationWithBlock:^{
        [self myLog:@"\n## receiving response..."];
        [self myLog:@"  %@", [response description]];
        [self myLog:@"\n## receiving body..."];
        //[self myLog:@"  %@", [data description]];
        [self myLog:@"\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
        
        NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
        NSDictionary *header = resp.allHeaderFields;
        if (resp.statusCode == 200 && [[header objectForKey:@"Content-Type"] containsString:@"application/json"]){
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self myLog:@"\n## parse Json..."];
            [self myLog:@"  %@", obj];
        }
        self.button.enabled = YES;
    }];
}
@end
