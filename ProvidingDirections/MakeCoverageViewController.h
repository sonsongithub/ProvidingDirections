//
//  MakeCoverageViewController.h
//  PrividingDirections
//
//  Created by sonson on 2012/09/25.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MakeCoverageViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPressGestureRecognizer;

- (IBAction)pushLong:(id)sender;

@end
