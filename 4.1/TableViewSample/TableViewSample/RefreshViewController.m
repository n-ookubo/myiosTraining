//
//  RefreshViewController.m
//  TableViewSample
//
//  Created by 大久保直昭 on 2015/07/14.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "RefreshViewController.h"

@interface RefreshViewController ()
{
    int rowCount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIActivityIndicatorView *act;
@property (weak, nonatomic) UITableViewCell *act_cell;

@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"最後尾をタップして更新";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    rowCount = 10;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return rowCount;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"hoge fuga piyo %ld", indexPath.row + 1];
    } else {
        cell.textLabel.text = @"タップして読み込み";
        _act_cell = cell;
        _act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _act.center = CGPointMake(cell.bounds.size.width / 2.0, cell.bounds.size.height / 2.0);
        [cell addSubview:_act];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _act.center = CGPointMake(_act_cell.bounds.size.width / 2.0, _act_cell.bounds.size.height / 2.0);
    [_act setHidden: NO];
    [_act_cell.textLabel setHidden:YES];
    [_act startAnimating];
    [self performSelector:@selector(didRefreshFinish:) withObject:tableView afterDelay:3.0];}

- (void)didRefreshFinish:(UITableView *)tableView
{
    rowCount += 10;
    [tableView reloadData];
    
    [_act stopAnimating];
    [_act setHidden:YES];
    [_act_cell.textLabel setHidden:NO];
}

@end
