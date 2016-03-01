//
//  HistoryViewController.m
//  PunchBilling
//
//  Created by sandeep kumar sharma on 28/02/16.
//  Copyright © 2016 ios dev . All rights reserved.
//

#import "HistoryViewController.h"
#import "checkoutViewController.h"

@interface HistoryViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *arrayHistory;
}
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrayHistory = [[NSUserDefaults standardUserDefaults] valueForKey:HISTORY_KEY];
}

- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
    NSDictionary *dict = arrayHistory[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Amount: ₹%@", dict[@"amount_bill"]];
    cell.detailTextLabel.text = dict[@"bill_id"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    checkoutViewController *checkoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"checkoutViewController"];
    checkoutVC.billDic = arrayHistory[indexPath.row];
    [self.navigationController pushViewController:checkoutVC animated:YES];
}

@end
