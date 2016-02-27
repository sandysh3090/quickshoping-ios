//
//  LocationListCell.h
//  DemoQucikShop
//
//  Created by SANDEEP SHARMA on 27/02/16.
//  Copyright (c) 2016 Softex Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationListCell : UITableViewCell
{
}
@property(nonatomic)IBOutlet UILabel *lblLoactionName;
@property(nonatomic)IBOutlet UILabel *lblLoactionAdddress;
@property(nonatomic)IBOutlet UILabel *lblLoactionDistance;
@property(nonatomic)IBOutlet UILabel *lblLoactionCity;
@property(nonatomic)IBOutlet UIButton *getdirectionBtn,*startshopingBtn,*conatcus;
@end
