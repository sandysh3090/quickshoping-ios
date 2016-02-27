//
//  checkoutViewController.m
//  PunchBilling
//
//  Created by sandeep kumar sharma on 27/02/16.
//  Copyright © 2016 Punchh Inc. All rights reserved.
//

#import "checkoutViewController.h"

@interface checkoutViewController ()

@end

@implementation checkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CIImage *img=[self createQRForString:self.billArray];
    qrcodeimage.image=[UIImage imageWithCIImage:img];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CIImage *)createQRForString:(NSString *)billstring {
     NSData *stringData = [@"sandeep" dataUsingEncoding: NSISOLatin1StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    return qrFilter.outputImage;
}

-(IBAction)BackBtnTap:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
