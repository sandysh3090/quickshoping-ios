//
//  CustomBarCodeScannerViewController.h
//  ios dev Framework
//
//  Created by sandeep sharma on 10/15/13.
//  Copyright (c) 2013 ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBarCodeScannerViewController : UIViewController

@property (nonatomic,assign) BOOL isBarCodeReader;
- (id) initWithBarButtonAction:(void(^)(NSInteger scannerButtonIndex))block;
@end
