//
//  FirstViewController.h
//  Mapa
//
//  Created by Rodrigo DAngelo Silva Machado on 5/11/15.
//  Copyright (c) 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapPin.h"
@import MapKit;
@import CoreLocation;

@interface FirstViewController : UIViewController <UIApplicationDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) CLLocationManager *lm;
@property (weak, nonatomic) IBOutlet UISearchBar *mysearch;
@property (nonatomic) NSInteger local;

@end

