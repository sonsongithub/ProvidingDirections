//
//  RouteViewController.h
//  ProvidingDirections
//
//  Created by sonson on 2012/10/25.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RouteViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) MKDirectionsRequest *request;
@property (nonatomic, strong) CLLocationManager	*manager;
@property (nonatomic, strong) CLLocation *currentLocation;

- (void)reload;

@end
