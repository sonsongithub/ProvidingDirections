//
//  MakeCoverageViewController.h
//  PrividingDirections
//
//  Created by sonson on 2012/09/25.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MakeCoverageViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *pins;
@property (strong, nonatomic) MKPolygon *polygon;
@property (strong, nonatomic) MKPolygonView *polygonView;

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)recognizer;
- (IBAction)output:(id)sender;

@end
