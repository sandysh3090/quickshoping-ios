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

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate> {
    CustomBarCodeScannerViewController *scannerController;
    AVCaptureSession *captureSession;
    NSMutableArray *listOfproduct;
    NSInteger updateindex;
    NSDictionary *editproductdic;
    AVCaptureVideoPreviewLayer *newCaptureVideoPreviewLayer;
}
@property (strong, nonatomic) UIView * codeScannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    listOfproduct =[[NSMutableArray alloc]init];
     editView.alpha=0.0;
    updateindex=0.0;

    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)scanBtnTap {
    
    if(scanButton.tag==0) {
        

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
        newCaptureVideoPreviewLayer.frame =CGRectMake(0, 60, 320, 150);// scannerController.view.bounds;
        newCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer insertSublayer:newCaptureVideoPreviewLayer above:self.view.layer];
        
        
        self.codeScannerView = [[BarCodeScannerView alloc] initWithFrame:CGRectMake(0, 60, 320, 150)                                                       withScannerAction:nil];
        
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
        [scanButton setTitle:@"Stop Scanning" forState:UIControlStateNormal];
    [captureSession startRunning];
    }
    else {
        scanButton.tag=0;
        [scanButton setTitle:@"Scan" forState:UIControlStateNormal];
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
        updateindex=0.0;
        editproductdic=[NSDictionary dictionaryWithObjectsAndKeys:@"lays",@"productname",@"5",@"productprice",@"4",@"ourprice",@"1",@"productquantity", nil];
        [self editModeforproduct];
        

    }
}





- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    updateindex=indexPath.row;
    editproductdic=[listOfproduct objectAtIndex:indexPath.row];;
    [self editModeforproduct];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listOfproduct.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    reviewTableViewCell *cell;
    static NSString *CellIdentifier = @"reviewTableViewCell";
    cell = (reviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell.productname.text=[[listOfproduct objectAtIndex:indexPath.row]valueForKey:@"productname"];
    cell.productprice.text=[NSString stringWithFormat:@"%@ ",[[listOfproduct objectAtIndex:indexPath.row]valueForKey:@"productquantity"]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}


-(void)editModeforproduct {
    productName.text=[editproductdic valueForKey:@"productname"];
    productPrice.text=[editproductdic valueForKey:@"productprice"];
    ourPrice.text=[editproductdic valueForKey:@"ourprice"];
    productQuantity.text=[editproductdic valueForKey:@"productquantity"];
    editView.alpha=1.0;
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
    NSMutableDictionary *tempdic=[NSMutableDictionary dictionaryWithDictionary:editproductdic];
    [tempdic setObject:productQuantity.text forKey:@"productquantity"];
    [listOfproduct insertObject:tempdic atIndex:updateindex];
    self.codeScannerView.alpha=1.0;
    newCaptureVideoPreviewLayer.hidden=NO;
    [captureSession startRunning];
    
    [listofproductTbl reloadData];

}

-(IBAction)minusBtnTap:(id)sender {
    if (productQuantity.text.integerValue>1) {
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

@end
