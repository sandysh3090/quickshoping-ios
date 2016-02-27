//
//  reviewTableViewCell.h
//  iriecustomer
//
//  Created by sandeep kumar sharma on 24/05/15.
//  Copyright (c) 2015 Sandeep Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reviewTableViewCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *productname,*productprice;
@property (nonatomic,strong) IBOutlet UIImageView *productImg;
@end
