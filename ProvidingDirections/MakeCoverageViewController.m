//
//  MakeCoverageViewController.m
//  PrividingDirections
//
//  Created by sonson on 2012/09/25.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import "MakeCoverageViewController.h"

#import "PinAnnotation.h"

@interface MakeCoverageViewController ()

@end

@implementation MakeCoverageViewController

#pragma mark - Instance method

- (void)removePins {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.pins removeAllObjects];
    [self.mapView removeOverlay:self.polygon];
    [self updatePinsPolygon];
}

- (void)updatePinsPolygon {
	CLLocationCoordinate2D *points = malloc(sizeof(CLLocationCoordinate2D) * self.pins.count);
	CLLocationCoordinate2D *p = points;
	
	for (PinAnnotation *pin in self.pins) {
		*(p++) = pin.coordinate;
	}
	
	[self.mapView removeOverlay:self.polygon];
	self.polygon = [MKPolygon polygonWithCoordinates:points count:self.pins.count];
	[self.mapView addOverlay:self.polygon];
}

- (void)dropPinAtPoint:(CGPoint)pointInMapView {
	CLLocationCoordinate2D convertedPoint = [self.mapView convertPoint: pointInMapView
                                                      toCoordinateFromView: self.mapView];
    PinAnnotation *pin = [[PinAnnotation alloc] init];
	pin.coordinate = convertedPoint;
	pin.title = [NSString stringWithFormat: @"Pin number %i", self.pins.count];
	pin.subtitle = [NSString stringWithFormat: @"%f, %f", convertedPoint.latitude, convertedPoint.longitude];
	
    [self.mapView addAnnotation:pin];
    [self.pins addObject:pin];
	[self updatePinsPolygon];
}

- (void)viewDidLoad {
	self.pins = [NSMutableArray array];
    [super viewDidLoad];
}

#pragma mark - IBAction

- (IBAction)output:(id)sender {
	NSLog(@"Output");
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
