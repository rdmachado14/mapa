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
    self.lm = [[CLLocationManager alloc] init];
    [self.lm requestAlwaysAuthorization];  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 200, 200);
    [self.map setRegion:[self.map regionThatFits:region] animated:YES];
}

@end
