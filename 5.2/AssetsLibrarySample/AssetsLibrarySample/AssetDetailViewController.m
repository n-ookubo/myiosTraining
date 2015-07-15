//
//  AssetDetailViewController.m
//  AssetsLibrarySample
//
//  Created by 大久保直昭 on 2015/07/15.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "AssetDetailViewController.h"

@interface AssetDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *dictionary;
@end

@implementation AssetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"asset details";
    
    NSArray *keys = @[ALAssetPropertyType, ALAssetPropertyLocation, ALAssetPropertyDuration, ALAssetPropertyOrientation, ALAssetPropertyDate, ALAssetPropertyRepresentations, ALAssetPropertyURLs, ALAssetPropertyAssetURL];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    for (NSString *key in keys) {
        id value = [_asset valueForProperty:key];
        if (value && value != ALErrorInvalidProperty) {
            [dictionary setObject:value forKey:key];
        }
    }
    _dictionary = [NSDictionary dictionaryWithDictionary:dictionary];
    [self setAsset:nil];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dictionary.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[_dictionary allKeys] objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [[[_dictionary allValues] objectAtIndex:indexPath.section] description];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2;
}
@end
