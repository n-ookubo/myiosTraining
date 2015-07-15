//
//  AssetViewController.m
//  AssetsLibrarySample
//
//  Created by 大久保直昭 on 2015/07/14.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "AssetViewController.h"
#import "AssetDetailViewController.h"

@interface AssetViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *assetArray;
@end

@implementation AssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@ (%ld)", [self.assetGroup valueForProperty:ALAssetsGroupPropertyName], [self.assetGroup numberOfAssets]];
    
    _assetArray = [NSMutableArray array];
    [_assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [_assetArray addObject:result];
        } else {
            [_tableView reloadData];
        }
    }];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
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
    return _assetArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    ALAsset *asset = [_assetArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [asset valueForProperty:ALAssetPropertyDate]];
    cell.imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssetDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AssetDetail"];
    controller.asset = [_assetArray objectAtIndex:indexPath.row];
    // 次画面の戻るボタンの設定
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    self.navigationItem.backBarButtonItem = back;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
