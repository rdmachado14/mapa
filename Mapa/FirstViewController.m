//
//  FirstViewController.m
//  Mapa
//
//  Created by Rodrigo DAngelo Silva Machado on 5/11/15.
//  Copyright (c) 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"


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
    ann1.title = @"Manauara Shopping";
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
    ann4.title = @"Millennium Shopping";
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

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *myPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    myPin.pinColor = MKPinAnnotationColorGreen;
    
    UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [advertButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    myPin.rightCalloutAccessoryView = advertButton;
    myPin.draggable = NO;
    myPin.highlighted = YES;
    myPin.animatesDrop = TRUE;
    myPin.canShowCallout = YES;
    
    return myPin;
    
}

- (void) button: (id) sender
{
    /*self.tabBarController.selectedIndex = 1;
    SecondViewController *uvc = [self.tabBarController.viewControllers objectAtIndex:1];*/
    
    //NSLog(@"Feito");
    
    
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

- (IBAction)local:(id)sender
{
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

- (IBAction)coordenadas:(id)sender
{
    // caminho para o Studio 5
    NSString *string1 = @"http://maps.apple.com/maps?daddr=-3.120470,-59.981877";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string1]];
    
    // caminho para o Manauara
    NSString *string2 = @"http://maps.apple.com/maps?daddr=-3.104249,-60.013606";
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string2]];
     
     // caminho para o amazonas shopping
     NSString *string3 = @"http://maps.apple.com/maps?daddr=-3.094275,-60.022632";
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string3]];
     
     // caminho para o millennium
     NSString *string4 = @"http://maps.apple.com/maps?daddr=-3.101028,-60.025077";
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string4]];
     
     // caminho para o ponta negra
     NSString *string5 = @"http://maps.apple.com/maps?daddr=-3.085060,-60.072378";
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string5]];
     
     // caminho para o plaza
     NSString *string6 = @"http://maps.apple.com/maps?daddr=-3.097410,-60.023012";
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string6]];

}
@end
