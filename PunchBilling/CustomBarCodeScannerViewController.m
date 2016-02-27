//
//  CustomBarCodeScannerViewController.m
//  Punchh Framework
//
//  Created by Hemant on 10/15/13.
//  Copyright (c) 2013 Punchh. All rights reserved.
//

#import "CustomBarCodeScannerViewController.h"
#import "BarCodeScannerView.h"
#import "QRCodeScannerView.h"

@interface CustomBarCodeScannerViewController ()
@property (copy, nonatomic) void(^scannerActionBlock)(NSInteger buttonTag);
@property (strong, nonatomic) UIView * codeScannerView;
@end

@implementation CustomBarCodeScannerViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithBarButtonAction:(void(^)(NSInteger scannerButtonIndex))block {
    if (self = [super init]) {
        self.scannerActionBlock = block;
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.codeScannerView) {
        //if (self.isBarCodeReader) {
           self.codeScannerView = [[QRCodeScannerView alloc] initWithFrame:self.view.frame];
      //  }
//        else {
//            self.codeScannerView = [[QRCodeScannerView alloc] initWithFrame:self.view.frame];
//        }
        [self.view addSubview:self.codeScannerView];
        UIImageView *_bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanner_top_bar"]];
        _bottomImageView.backgroundColor = [UIColor blackColor];
        [_bottomImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_bottomImageView setFrame:CGRectMake(0, self.view.frame.size.height - 48, 320, 61)];
        [self.codeScannerView addSubview:_bottomImageView];

        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self
                         action:@selector(cancelButtonTapped:)
               forControlEvents:UIControlEventTouchUpInside];
        //cancelButton.fontName = APP_FONT_FAMILY;
        cancelButton.frame = CGRectMake(10, self.view.frame.size.height - 45, 80, 40);
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.codeScannerView addSubview:cancelButton];
    }
    if ([self.codeScannerView isKindOfClass:[BarCodeScannerView class]]) {
        [(BarCodeScannerView *)self.codeScannerView translateDown];
    }
}

- (void) cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES
							 completion:nil];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void) didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
