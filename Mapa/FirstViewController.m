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
    
    MKCoordinateRegion region = {{0.0 , 0.0} , {0.0 , 0.0}};
    
    // setando a posição do manauara
    region.center.latitude = -3.104249;
    region.center.longitude = -60.013606;
    region.span.longitudeDelta = 0.0f;
    region.span.latitudeDelta = 0.0f;
    [_map setRegion:region animated:YES];
    MapPin *ann1 = [[MapPin alloc]init];
    ann1.title = @"Manaura Shopping";
    ann1.subtitle = @"PlayArt";
    ann1.coordinate = region.center;
    [_map addAnnotation:ann1];
    
    
    // setando a posição do studio 5
    region.center.latitude = -3.120470;
    region.center.longitude = -59.981877;
    region.span.longitudeDelta = 0.0f;
    region.span.latitudeDelta = 0.0f;
    [_map setRegion:region animated:YES];
    MapPin *ann2 = [[MapPin alloc]init];
    ann2.title = @"Studio 5";
    ann2.subtitle = @"Cinemark";
    ann2.coordinate = region.center;
    [_map addAnnotation:ann2];
    
    // setando a posição do amazonas
    region.center.latitude = -3.094275;
    region.center.longitude = -60.022632;
    region.span.longitudeDelta = 0.0f;
    region.span.latitudeDelta = 0.0f;
    [_map setRegion:region animated:YES];
    MapPin *ann3 = [[MapPin alloc]init];
    ann3.title = @"Amazonas Shopping";
    ann3.subtitle = @"Kinoplex";
    ann3.coordinate = region.center;
    [_map addAnnotation:ann3];
    
    // setando a posição do millennium
    region.center.latitude = -3.101028;
    region.center.longitude = -60.025077;
    region.span.longitudeDelta = 0.0f;
    region.span.latitudeDelta = 0.0f;
    [_map setRegion:region animated:YES];
    MapPin *ann4 = [[MapPin alloc]init];
    ann4.title = @"Millennium Shpping";
    ann4.subtitle = @"Cinépolis";
    ann4.coordinate = region.center;
    [_map addAnnotation:ann4];
    
    // setando a posição do ponta negra
    region.center.latitude = -3.085060;
    region.center.longitude = -60.072378;
    region.span.longitudeDelta = 0.0f;
    region.span.latitudeDelta = 0.0f;
    [_map setRegion:region animated:YES];
    MapPin *ann5 = [[MapPin alloc]init];
    ann5.title = @"Shopping Ponta Negra";
    ann5.subtitle = @"Cinépolis";
    ann5.coordinate = region.center;
    [_map addAnnotation:ann5];
    
    // setando a posição do plaza
    region.center.latitude = -3.097410;
    region.center.longitude = -60.023012;
    region.span.longitudeDelta = 0.0f;
    region.span.latitudeDelta = 0.0f;
    [_map setRegion:region animated:YES];
    MapPin *ann6 = [[MapPin alloc]init];
    ann6.title = @"Manaus Plaza Shopping";
    ann6.subtitle = @"Cinemais";
    ann6.coordinate = region.center;
    [_map addAnnotation:ann6];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.mysearch resignFirstResponder];
    
    // instanciando geolocalização
    CLGeocoder *gc = [[CLGeocoder alloc] init];
    [gc geocodeAddressString:self.mysearch.text completionHandler:^(NSArray *placemarks, NSError *error)
    {
        // marca localização
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        MKCoordinateRegion region;
        CLLocationCoordinate2D newLocation = [placemark.location coordinate];
        region.center = [(CLCircularRegion *) placemark.region center];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:newLocation];
        [annotation setTitle:self.mysearch.text];
        [self.map addAnnotation:annotation];
        
        // scroll para a busca
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

/*- (instancetype)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude
{
    latitude = -3.113001;
    longitude = -59.982060;
    
    return self;
}*/

/*- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Override point for customization after app launch
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
    
    CLLocationCoordinate2D coord;
    coord.longitude = -111.936619;
    coord.latitude = 33.416199;
    
    MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coord];
    [geocoder setDelegate:self];
    [geocoder start]
}*/

/*-(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
      NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%f,%f&output=csv",pdblLatitude, pdblLongitude];
      NSError* error;
      NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];
       // NSLog(@"%@",locationString);
    
      locationString = [locationString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
      return [locationString substringFromIndex:6];
}*/

@end
