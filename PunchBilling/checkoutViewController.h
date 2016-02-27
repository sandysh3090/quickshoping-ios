//
//  checkoutViewController.h
//  PunchBilling
//
//  Created by sandeep kumar sharma on 27/02/16.
//  Copyright © 2016 ios dev Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checkoutViewController : UIViewController {
    IBOutlet UIImageView *qrcodeimage;
    IBOutlet UIButton *backtohome;
}
@property(nonatomic,strong) NSDictionary *billDic;

@end
