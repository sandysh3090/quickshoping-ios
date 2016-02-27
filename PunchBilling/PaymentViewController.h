//
//  PaymentViewController.h
//  DemoQucikShop
//
//  Created by SANDEEP SHARMA on 27/02/16.
//  Copyright (c) 2016 Softex Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKCardNumberField.h"
#import "BKCardExpiryField.h"
#import "UserCart.h"

@interface PaymentViewController : UIViewController
{
    IBOutlet UIButton *btnCash, *btnCard;
    IBOutlet UILabel *totalAmount;
    IBOutlet UIImageView *orimg;
}
@property (nonatomic,strong)UserCart *usercart;

@end
