//
//  LocationListViewController.m
//  DemoQucikShop
//
//  Created by SANDEEP SHARMA on 27/02/16.
//  Copyright (c) 2016 Softex Lab. All rights reserved.
//

#import "LocationListViewController.h"
#import "LocationListCell.h"
#import <MapKit/MapKit.h>

@interface LocationListViewController ()
{
    NSArray *arrLocationList;
}
@end

@implementation LocationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [@"28.5827577" doubleValue];
    coordinate.longitude = [@"77.0334179" doubleValue];
    customOverlayMap.region = MKCoordinateRegionMakeWithDistance(coordinate, 20000, 20000);
//    [customOverlayMap setRegion:region animated:NO];
   // [customOverlayMap regionThatFits:region];
    
    // Do any additional setup after loading the view.
    NSDictionary *temdic=[[NSDictionary alloc]initWithObjectsAndKeys:@"Reliance Fresh",@"location",@"155,Purani delhi railway station",@"Address",@"28.5827577",@"lattitude",@"77.0334179",@"longitude",@"+918955767558",@"contactdetail", nil];
    NSDictionary *temdic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"Reliance Fresh",@"location",@"25, near Jaipur Railway Station",@"Address",@"26.91978",@"lattitude",@"75.78790",@"longitude",@"8955767558",@"contactdetail", nil];
    NSDictionary *temdic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Reliance Trand",@"location",@"155,Purani delhi railway station",@"Address",@"28.66097",@"lattitude",@"77.22767",@"longitude",@"8955767558",@"contactdetail", nil];
    NSDictionary *temdic3=[[NSDictionary alloc]initWithObjectsAndKeys:@"Vishal Megamart",@"location",@"155,Purani delhi railway station",@"Address",@"28.66097",@"lattitude",@"77.22767",@"longitude",@"8955767558",@"contactdetail", nil];
    NSDictionary *temdic4=[[NSDictionary alloc]initWithObjectsAndKeys:@"Big Bazar",@"location",@"155,Purani delhi railway station",@"Address",@"28.66097",@"lattitude",@"77.22767",@"longitude",@"8955767558",@"contactdetail", nil];
    NSDictionary *temdic5=[[NSDictionary alloc]initWithObjectsAndKeys:@"Chinkara canteen",@"location",@"155,Purani delhi railway station",@"Address",@"28.66097",@"lattitude",@"-77.22767",@"longitude",@"8955767558",@"contactdetail", nil];
    arrLocationList=[[NSArray alloc] initWithObjects:temdic,temdic1,temdic2,temdic3,temdic4,temdic5, nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrLocationList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid=@"Locationcell";
    
    LocationListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid ];
    if (!cell) {
        cell=(LocationListCell *)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.lblLoactionName.text=[[arrLocationList objectAtIndex:indexPath.row] valueForKey:@"location"];
    cell.lblLoactionAdddress.text=[[arrLocationList objectAtIndex:indexPath.row] valueForKey:@"Address"];
    [cell.startshopingBtn addTarget:self action:@selector(btnscanTAp:) forControlEvents:UIControlEventTouchUpInside];
    cell.conatcus.tag=indexPath.row;
    cell.getdirectionBtn.tag=indexPath.row;
    [cell.conatcus addTarget:self action:@selector(phoneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.getdirectionBtn addTarget:self action:@selector(getDirectionsTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //cell.titellbl.text=[[dataArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    //cell.detilatitlelbl.text=[[dataArray objectAtIndex:indexPath.row]valueForKey:@"email"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"table view selected cell index is %ld",(long)indexPath.row);
}


-(IBAction)btnscanTAp:(id)sender{
    [self performSegueWithIdentifier:@"scanproduct" sender:nil];
}

- (IBAction)phoneButtonTapped:(id)sender {
    UIButton *btn=(UIButton *)sender;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[arrLocationList objectAtIndex:btn.tag] valueForKey:@"location"]
                                                    message:[[arrLocationList objectAtIndex:btn.tag] valueForKey:@"contactdetail"]
                                                   delegate: self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Call", nil];
    alert.tag=btn.tag;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
        }
            break;
        case 1:
        {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[arrLocationList objectAtIndex:alertView.tag] valueForKey:@"contactdetail"]]];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
        default:
            break;
    }
}

- (IBAction)getDirectionsTapped:(id)sender {
    UIButton *btn=(UIButton *)sender;
    CLLocationCoordinate2D location;
    location.latitude = [[[arrLocationList objectAtIndex:btn.tag] valueForKey:@"lattitude"] doubleValue];
    location.longitude = [[[arrLocationList objectAtIndex:btn.tag] valueForKey:@"longitude"] doubleValue];
    
    MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate:location  addressDictionary: nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    destination.name = [[arrLocationList objectAtIndex:btn.tag] valueForKey:@"location"];
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving };
    [MKMapItem openMapsWithItems:@[destination] launchOptions: options];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
