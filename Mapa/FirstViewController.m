//
//  FirstViewController.m
//  Mapa
//
//  Created by Rodrigo DAngelo Silva Machado on 5/11/15.
//  Copyright (c) 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

#import "FirstViewController.h"


@interface FirstViewController ()


@end

@implementation FirstViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mysearch.delegate = self;
    self.map.delegate = self;
    self.lm = [[CLLocationManager alloc] init];
    [self.lm requestAlwaysAuthorization];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.mysearch resignFirstResponder];
    
    CLGeocoder *gc = [[CLGeocoder alloc] init];
    [gc geocodeAddressString:self.mysearch.text completionHandler:^(NSArray *placemarks, NSError *error)
    {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        MKCoordinateRegion region;
        CLLocationCoordinate2D newLocation = [placemark.location coordinate];
        region.center = [(CLCircularRegion *) placemark.region center];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:newLocation];
        [annotation setTitle:self.mysearch.text];
        [self.map addAnnotation:annotation];
        
        MKMapRect mr = [self.map visibleMapRect];
        MKMapPoint pt = MKMapPointForCoordinate([annotation coordinate]);
        mr.origin.x = pt.x - mr.size.width * 0.5;
        mr.origin.y = pt.y - mr.size.height * 0.25;
        [self.map setVisibleMapRect:mr animated:YES];
        
        
    }];
    
}
- (IBAction)local:(id)sender {
    _local = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (_local == 1) {
        
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 200, 200);
    [self.map setRegion:[self.map regionThatFits:region] animated:YES];
        _local = 0;
    }
}

@end
