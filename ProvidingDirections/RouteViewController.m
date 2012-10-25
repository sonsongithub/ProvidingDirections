//
//  RouteViewController.m
//  ProvidingDirections
//
//  Created by sonson on 2012/10/25.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import "RouteViewController.h"

#import "PinAnnotation.h"

@interface RouteViewController ()

@end

@implementation RouteViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.manager = [[CLLocationManager alloc] init];
	self.manager.delegate = self;
	self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	self.manager.pausesLocationUpdatesAutomatically = YES;
	[self.manager startUpdatingLocation];
}

- (void)reload {
	NSLog(@"reload");
	MKMapItem *source = self.request.source;
	MKMapItem *destination = self.request.destination;
	
	PinAnnotation *sourcePin = [[PinAnnotation alloc] init];
	PinAnnotation *destinationPin = [[PinAnnotation alloc] init];
	
	if (!source.isCurrentLocation) {
		sourcePin.coordinate = source.placemark.location.coordinate;
		sourcePin.title = source.placemark.title;
		sourcePin.subtitle = [NSString stringWithFormat:@"(%f, %f)", source.placemark.location.coordinate.longitude, source.placemark.location.coordinate.latitude];
	}
	else {
		sourcePin.coordinate = self.currentLocation.coordinate;
		sourcePin.title = NSLocalizedString(@"Current", nil);
	}
	
	if (!destination.isCurrentLocation) {
		destinationPin.coordinate = destination.placemark.location.coordinate;
		destinationPin.title = destination.placemark.title;
		destinationPin.subtitle = [NSString stringWithFormat:@"(%f, %f)", destination.placemark.location.coordinate.longitude, destination.placemark.location.coordinate.latitude];
	}
	else {
		destinationPin.coordinate = self.currentLocation.coordinate;
		destinationPin.title = NSLocalizedString(@"Current", nil);
	}
	
	[self.mapView addAnnotation:sourcePin];
	[self.mapView addAnnotation:destinationPin];
	
	CLLocationCoordinate2D center = CLLocationCoordinate2DMake(
															   (sourcePin.coordinate.latitude + destinationPin.coordinate.latitude)/2,
															   (sourcePin.coordinate.longitude + destinationPin.coordinate.longitude)/2
	);
	float rangeLatitiude = fabsf(sourcePin.coordinate.latitude - destinationPin.coordinate.latitude);
	float rangeLongitude = fabsf(sourcePin.coordinate.longitude - destinationPin.coordinate.longitude);
	
	MKCoordinateRegion region = MKCoordinateRegionMake(
													   center,
													   MKCoordinateSpanMake(rangeLatitiude, rangeLongitude)
													   );
	
	[self.mapView setRegion:region animated:YES];
}

- (void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray*)locations {
	NSLog(@"%@", locations);
	self.currentLocation = [locations lastObject];
	[self.manager stopUpdatingLocation];
	[self reload];
}

@end
