//
//  LocationListViewController.h
//  DemoQucikShop
//
//  Created by SANDEEP SHARMA on 27/02/16.
//  Copyright (c) 2016 Softex Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblLocationList;
    IBOutlet MKMapView *customOverlayMap;
}
@end
