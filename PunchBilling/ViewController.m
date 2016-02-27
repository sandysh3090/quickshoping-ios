//
//  ViewController.m
//  PunchBilling
//
//  Created by sandeep kumar sharma on 24/02/16.
//  Copyright © 2016 Punchh Inc. All rights reserved.
//

#import "ViewController.h"
#import "PunchhZBarReaderViewController.h"
#import "BarCodeScannerView.h"
#import "CustomBarCodeScannerViewController.h"
#import "reviewTableViewCell.h"
#import "PunchhSoapApiClient.h"
#import "MBProgressHUD.h"
#import "JSON.h"
#import "checkoutViewController.h"
#import "Item.h"
#import "ItemDetails.h"
#import "UserCart.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate> {
    CustomBarCodeScannerViewController *scannerController;
    AVCaptureSession *captureSession;
    NSInteger updateindex;
    AVCaptureVideoPreviewLayer *newCaptureVideoPreviewLayer;
    Item * selectedItem;
    NSDictionary *billDIC;
}
@property (strong, nonatomic) UIView * codeScannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
     editView.alpha=0.0;
    editsubview.layer.cornerRadius=5.0;
    editsubview.clipsToBounds=YES;
    updateindex=0.0;
    
    
    self.codeScannerView.alpha=1.0;
    if (!self.codeScannerView ) {
        captureSession = [[AVCaptureSession alloc] init];
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                            error:&error];
        if (!input) {
            NSLog(@"Error: %@", error);
            return;
        }
        [captureSession addInput:input];
        
        //Turn on point autofocus for middle of view
        [device lockForConfiguration:&error];
        if ([device isFocusPointOfInterestSupported]) {
            CGPoint point = CGPointMake(0.5,0.5);
            [device setFocusPointOfInterest:point];
            [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        }
        [device unlockForConfiguration];
        
        //Add the metadata output device
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [captureSession addOutput:output];
        
        //You should check here to see if the session supports these types, if they aren't support you'll get an exception
        output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode];
        newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
        newCaptureVideoPreviewLayer.frame =CGRectMake(0, 60, 320, 119);// scannerController.view.bounds;
        newCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer insertSublayer:newCaptureVideoPreviewLayer above:self.view.layer];
        
        
        self.codeScannerView = [[BarCodeScannerView alloc] initWithFrame:CGRectMake(0, 60, 320, 119)                                                       withScannerAction:nil];
        
        [self.view addSubview:self.codeScannerView];
        UIImageView *_bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanner_top_bar"]];
        _bottomImageView.backgroundColor = [UIColor blackColor];
        [_bottomImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_bottomImageView setFrame:CGRectMake(0, self.view.frame.size.height - 48, 320, 61)];
        //[self.codeScannerView addSubview:_bottomImageView];
        
        if ([self.codeScannerView isKindOfClass:[BarCodeScannerView class]]) {
            [(BarCodeScannerView *)self.codeScannerView translateDown];
        }
    }
    scanButton.tag=1;
    [scanButton setTitle:@"STOP SCANNING" forState:UIControlStateNormal];
    [captureSession startRunning];

    // Do any additional setup after loading the view, typically from a nib.
}
-(IBAction)backBtnTap:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)scanBtnTap {
    
    if(scanButton.tag==0) {
        scanButton.tag=1;
        [scanButton setTitle:@"STOP SCANNING" forState:UIControlStateNormal];
        [captureSession startRunning];
    }
    else {
        scanButton.tag=0;
        [scanButton setTitle:@"START SCANNING" forState:UIControlStateNormal];
        self.codeScannerView.alpha=0.0;
        [captureSession stopRunning];
    }
}
- (void)dismissPickerAndStartManualCheckinProcess:(NSInteger)buttonIndex {
}

- (void) cancelButtonTapped:(id)sender {
    self.codeScannerView.alpha=0.0;
    [captureSession stopRunning];
}

- (void) captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
        fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count) {
        AVMetadataObject *metadata = metadataObjects[0];
            NSString *code = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
        NSLog(@"code %@",code);
       self.codeScannerView.alpha=0.0;
        newCaptureVideoPreviewLayer.hidden=YES;
        [captureSession stopRunning];
        [self getProductDetails:code];
        
    }
}


-(void)getProductDetails:(NSString *)barcode {
    NSError *error;
        NSString *str = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@product/scan/%@",API_PATH,barcode]] encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"data %@ error %@", str, error);
    if (!error) {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",dictionary);
        
        selectedItem = [[Item alloc] initWithDictionary:dictionary];
        
        updateindex=0.0;
        [self editModeforproduct];
    } else {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not reachable,try again later" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        self.codeScannerView.alpha=1.0;
        newCaptureVideoPreviewLayer.hidden=NO;
        [captureSession stopRunning];
    }

   
}




- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    updateindex=indexPath.row;
     selectedItem = [[UserCart sharedCart].itemDetails objectAtIndex:indexPath.row].item;
    self.codeScannerView.alpha=0.0;
    newCaptureVideoPreviewLayer.hidden=YES;
    [self editModeforproduct];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [UserCart sharedCart].itemDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    reviewTableViewCell *cell;
    static NSString *CellIdentifier = @"reviewTableViewCell";
    cell = (reviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell.productname.text=[[UserCart sharedCart].itemDetails objectAtIndex:indexPath.row].item.title;
    cell.productprice.text=[[UserCart sharedCart].itemDetails objectAtIndex:indexPath.row].itemOurPrice;
    cell.productdetail.text=[[UserCart sharedCart].itemDetails objectAtIndex:indexPath.row].item.detail;
    cell.productqualty.text=[NSString stringWithFormat:@"QTY:%@",[[UserCart sharedCart].itemDetails objectAtIndex:indexPath.row].itemQty];
    [cell.productImg sd_setImageWithURL:[NSURL URLWithString:IMG_STR_URL([[UserCart sharedCart].itemDetails objectAtIndex:indexPath.row].item.image,@"120",@"120")] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRetryFailed];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}


-(void)editModeforproduct {
    productName.text = selectedItem.title;
    productPrice.text = [NSString stringWithFormat:@"MRP:%@ Rs",selectedItem.orignalPrice];
    ourPrice.text = [NSString stringWithFormat:@"Our Price:%@ Rs",selectedItem.ourPrice];
    productdetail.text=selectedItem.detail;
   [productimg sd_setImageWithURL:[NSURL URLWithString:IMG_STR_URL(selectedItem.image,@"280",@"280")] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRetryFailed];
    productQuantity.text = @"1";
    editView.alpha = 1.0;
    [editView bringSubviewToFront:self.view];
}


-(IBAction)cancelBtnTap:(id)sender {
    editView.alpha=0.0;
    self.codeScannerView.alpha=1.0;
    newCaptureVideoPreviewLayer.hidden=NO;
    [captureSession startRunning];
}

-(IBAction)AddtoCartBtnTap:(id)sender {
    [captureSession startRunning];
    editView.alpha=0.0;
    ItemDetails * itemDetails = [[ItemDetails alloc] init];
    itemDetails.item = selectedItem;
    itemDetails.itemQty = productQuantity.text;
    itemDetails.itemOrignalCost = [NSString stringWithFormat:@"%0.2f",[selectedItem.orignalPrice floatValue] * [productQuantity.text floatValue]];
    itemDetails.itemOurPrice = [NSString stringWithFormat:@"%0.2f",[selectedItem.ourPrice floatValue] * [productQuantity.text floatValue]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"item.scanCode MATCHES %@", selectedItem.scanCode];
    NSArray *filteredArray = [[UserCart sharedCart].itemDetails filteredArrayUsingPredicate:predicate];
    if (filteredArray.count>0) {
        if (itemDetails.itemQty.intValue==0) {
            [[UserCart sharedCart].itemDetails removeObjectAtIndex:[[UserCart sharedCart].itemDetails indexOfObject:[filteredArray objectAtIndex:0]]];
        } else {
            [[UserCart sharedCart].itemDetails replaceObjectAtIndex:[[UserCart sharedCart].itemDetails indexOfObject:[filteredArray objectAtIndex:0]] withObject:itemDetails];
        }
    } else {
        if (itemDetails.itemQty.intValue!=0) {
             [[UserCart sharedCart].itemDetails addObject:itemDetails];
        }       
    }
    
    self.codeScannerView.alpha=1.0;
    newCaptureVideoPreviewLayer.hidden=NO;
    [captureSession startRunning];
    
    [listofproductTbl reloadData];

}

-(IBAction)minusBtnTap:(id)sender {
    if (productQuantity.text.integerValue>0) {
        productQuantity.text=[NSString stringWithFormat:@"%ld",productQuantity.text.integerValue-1];
    }
}

-(IBAction)addtionBtnTap:(id)sender {
    productQuantity.text=[NSString stringWithFormat:@"%ld",productQuantity.text.integerValue+1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)checkOutBtnTap:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks"
                                                    message:@"Complete your shoping."
                                                   delegate: self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
        }
            break;
        case 1:
        {
            PunchhSoapApiClient *service = [[PunchhSoapApiClient alloc] init];
            NSDictionary *bodyD=[[UserCart sharedCart] dictionaryRepresentation];
            [service getSoapApiResponse:[NSString stringWithFormat:@"%@bill/YES",API_PATH] setHTTPMethod:@"POST" bodydata:[bodyD JSONRepresentation] success:^(AFHTTPRequestOperation *operation, NSDictionary* response) {
                NSLog(@"ghgh %@",response);
                billDIC=[[NSDictionary alloc]initWithDictionary:response];
                [self performSegueWithIdentifier:@"chekoutViewcontroller" sender:nil];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not reachable,try again later" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }];
        }
            break;
        default:
            break;
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"chekoutViewcontroller"]) {
        checkoutViewController *viewController = segue.destinationViewController;
       viewController.billDic = billDIC;
    }
}

@end
