 //
//  ViewController.h
//  PunchBilling
//
//  Created by sandeep kumar sharma on 24/02/16.
//  Copyright © 2016 Punchh Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController {
    IBOutlet UIButton *scanButton ,*cacelBtn,*addtoCartBtn,*addBtn,*minusBtn;
    IBOutlet UITableView *listofproductTbl;
    IBOutlet UIView *editView,*editsubview;
    IBOutlet UILabel *productName,*productPrice,*ourPrice,*productQuantity,*productdetail;
    IBOutlet UIImageView *productimg;
    
}


@end

