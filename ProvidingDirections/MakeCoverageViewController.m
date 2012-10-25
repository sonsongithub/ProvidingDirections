//
//  MakeCoverageViewController.m
//  PrividingDirections
//
//  Created by sonson on 2012/09/25.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import "MakeCoverageViewController.h"

#import "PinAnnotation.h"

#import <pwd.h>

@interface MakeCoverageViewController ()

@end

@implementation MakeCoverageViewController

#pragma mark - Instance method

- (void)writeGeoJSONToUserDesktop {
	NSString *path = [[self homeDirectory] stringByAppendingPathComponent:@"Desktop/region.geojson"];
	NSData *data = [self geoJSONData];
	[data writeToFile:path atomically:YES];
}

- (NSString *) homeDirectory {
	NSString *logname = [NSString stringWithCString:getenv("LOGNAME") encoding:NSUTF8StringEncoding];
	struct passwd *pw = getpwnam([logname UTF8String]);
	return pw ? [NSString stringWithCString:pw->pw_dir encoding:NSUTF8StringEncoding] : [@"/Users" stringByAppendingPathComponent:logname];
}

- (NSData*)geoJSONData {
	NSError *error = nil;
	NSMutableArray *coordinates = [NSMutableArray array];
	for (PinAnnotation *annotation in self.pins)
		[coordinates addObject:@[@(annotation.coordinate.longitude), @(annotation.coordinate.latitude)]];
	
	NSDictionary *json = @{@"type":@"MultiPolygon", @"coordinates":@[@[coordinates]]};
	NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:&error];
	if (error) {
		NSLog(@"%@", [error localizedDescription]);
		return nil;
	}
	return data;
}

- (NSString*)geoJSONString {
	NSData *data = [self geoJSONData];
	return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)removePins {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.pins removeAllObjects];
    [self.mapView removeOverlay:self.polygon];
    [self updatePinsPolygon];
}

- (void)updatePinsPolygon {
	CLLocationCoordinate2D *points = malloc(sizeof(CLLocationCoordinate2D) * self.pins.count);
	CLLocationCoordinate2D *p = points;
	
	for (PinAnnotation *pin in self.pins)
		*(p++) = pin.coordinate;
	
	[self.mapView removeOverlay:self.polygon];
	self.polygon = [MKPolygon polygonWithCoordinates:points count:self.pins.count];
	[self.mapView addOverlay:self.polygon];
}

- (void)dropPinAtPoint:(CGPoint)pointInMapView {
	CLLocationCoordinate2D convertedPoint = [self.mapView convertPoint: pointInMapView
                                                      toCoordinateFromView: self.mapView];
    PinAnnotation *pin = [[PinAnnotation alloc] init];
	pin.coordinate = convertedPoint;
	pin.title = [NSString stringWithFormat: @"Pin %i", self.pins.count + 1];
	pin.subtitle = [NSString stringWithFormat: @"(%f, %f)", convertedPoint.latitude, convertedPoint.longitude];
	
    [self.mapView addAnnotation:pin];
    [self.pins addObject:pin];
	[self updatePinsPolygon];
}

#pragma mark - ViewController

- (void)viewDidLoad {
	self.pins = [NSMutableArray array];
    [super viewDidLoad];
}

#pragma mark - IBAction

- (IBAction)output:(id)sender {
	[self geoJSONString];
#if TARGET_IPHONE_SIMULATOR
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirmation", nil)
														message:NSLocalizedString(@"Output GeoJSON to your Desktop?", nil)
													   delegate:self
											  cancelButtonTitle:NSLocalizedString(@"No", nil)
											  otherButtonTitles:NSLocalizedString(@"YES", nil), nil];
	[alertView show];
#else
	[self removePins];
#endif
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
	}
	else if (buttonIndex == 1) {
		[self writeGeoJSONToUserDesktop];
	}
	[self removePins];
}

#pragma mark - Gesture handler

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
		NSLog(@"Long press");
		[self dropPinAtPoint:[recognizer locationInView:self.mapView]];
    }
}

#pragma mark - MKMapViewDelegate

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if (self.polygonView && self.polygonView.polygon == self.polygon)
        return self.polygonView;
    
    self.polygonView = [[MKPolygonView alloc] initWithPolygon:self.polygon];
    self.polygonView.fillColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.3f];
    self.polygonView.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.9f];
    self.polygonView.lineWidth = 1.0f;
	
    return self.polygonView;
}

@end
