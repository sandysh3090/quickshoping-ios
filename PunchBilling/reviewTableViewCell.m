//
//  reviewTableViewCell.m
//  iriecustomer
//
//  Created by sandeep kumar sharma on 24/05/15.
//  Copyright (c) 2015 Sandeep Sharma. All rights reserved.
//

#import "reviewTableViewCell.h"

@implementation reviewTableViewCell
@synthesize productname,productprice,productImg,productdetail,productqualty;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
