//
//  checkoutViewController.h
//  PunchBilling
//
//  Created by sandeep kumar sharma on 27/02/16.
//  Copyright © 2016 Punchh Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checkoutViewController : UIViewController {
    IBOutlet UIImageView *qrcodeimage;
}
@property(nonatomic,strong) NSDictionary *billDic;

@end
