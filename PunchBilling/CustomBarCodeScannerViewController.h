//
//  CustomBarCodeScannerViewController.h
//  Punchh Framework
//
//  Created by Hemant on 10/15/13.
//  Copyright (c) 2013 Punchh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBarCodeScannerViewController : UIViewController

@property (nonatomic,assign) BOOL isBarCodeReader;
- (id) initWithBarButtonAction:(void(^)(NSInteger scannerButtonIndex))block;
@end
