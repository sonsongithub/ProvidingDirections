//
//  AppDelegate.m
//  ProvidingDirections
//
//  Created by sonson on 2012/10/09.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import "AppDelegate.h"

#import <MapKit/MapKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
			openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
		 annotation:(id)annotation {
	if ([MKDirectionsRequest isDirectionsRequestURL:url]) {
		MKDirectionsRequest* directionsInfo = [[MKDirectionsRequest alloc] initWithContentsOfURL:url];
		// TO DO: Plot and display the route using the
		//   source and destination properties of directionsInfo.
		NSLog(@"provides");
		NSLog(@"%@", directionsInfo);
		return YES;
	}
	else {
		// Handle other URL types...
	}
    return NO;
}

@end
