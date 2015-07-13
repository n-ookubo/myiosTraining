//
//  CustomCellViewController.m
//  TableViewSample
//
//  Created by 大久保直昭 on 2015/07/13.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "CustomCellViewController.h"
#import "MyTableViewCell.h"
#import "MyTableViewController.h"

@interface CustomCellViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CustomCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"カスタムUITableViewCellテスト";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(showNextView)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"maimai"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell2" bundle:nil] forCellReuseIdentifier:@"daisuke"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNextView
{
    MyTableViewController *controller = [[MyTableViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = indexPath.row % 2 == 0 ? @"maimai" : @"daisuke";
    MyTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    cell.label.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
