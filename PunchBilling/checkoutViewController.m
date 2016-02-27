//
//  checkoutViewController.m
//  PunchBilling
//
//  Created by sandeep kumar sharma on 27/02/16.
//  Copyright © 2016 ios dev Inc. All rights reserved.
//

#import "checkoutViewController.h"
#import "LocationListViewController.h"
#import "UserCart.h"

@interface checkoutViewController ()

@end

@implementation checkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"billdic%@",self.billDic);
    backtohome.layer.cornerRadius=5.0;
    [self storeBillHisotry:self.billDic];
    CIImage *img=[self createQRForString:[self.billDic valueForKey:@"bill_id"]];
    qrcodeimage.image=[UIImage imageWithCIImage:img];
    // Do any additional setup after loading the view.
}

- (void)storeBillHisotry:(NSDictionary*)dict {
    NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arrM = [[stdDefault valueForKey:HISTORY_KEY] mutableCopy];
    if (!arrM) {
        arrM = [NSMutableArray new];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bill_id=%@", dict[@"bill_id"]];
    NSArray *arrCheck = [arrM filteredArrayUsingPredicate:predicate];
    if (!(arrCheck && arrCheck.count)) {
        if (dict) {
            [arrM insertObject:dict atIndex:0];
            [stdDefault setValue:arrM forKey:HISTORY_KEY];
            [stdDefault synchronize];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CIImage *)createQRForString:(NSString *)billstring {
     NSData *stringData = [billstring dataUsingEncoding: NSISOLatin1StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    return qrFilter.outputImage;
}

-(IBAction)BacktohomeBtnTap:(id)sender {
//    LocationListViewController *locationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"locationviewcontroller"];
//    [self.navigationController pushViewController:locationViewController animated:YES];
    [[UserCart sharedCart] emptyCart];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
